import 'package:developer_company/data/implementations/loan_application_repository_impl.dart';
import 'package:developer_company/data/models/loan_application_model.dart';
import 'package:developer_company/data/providers/loan_application_provider.dart';
import 'package:developer_company/data/repositories/loan_application_repository.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/validations/days_old_validator.dart';
import 'package:developer_company/shared/validations/dpi_validator.dart';
import 'package:developer_company/shared/validations/grater_than_number_validator.dart';
import 'package:developer_company/shared/validations/lower_than_number_validator%20copy.dart';
// import 'package:developer_company/shared/validations/image_button_validator.dart';
import 'package:developer_company/shared/validations/nit_validation.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/string_length_validator.dart';
import 'package:developer_company/shared/validations/years_old_validator.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/date_picker.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ClientQuotePage extends StatefulWidget {
  const ClientQuotePage({Key? key}) : super(key: key);

  @override
  State<ClientQuotePage> createState() => _ClientQuotePageState();
}

class _ClientQuotePageState extends State<ClientQuotePage> {
  final GlobalKey<FormState> _formKeyApplyQuote = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());
  final Map<String, dynamic> arguments = Get.arguments;
  bool isEditMode = true;
  bool isFirstTime = true;
  String? _applicationId;
  int actualYear = DateTime.now().year;

  LoanApplicationRepository loanApplicationRepository =
      LoanApplicationRepositoryImpl(LoanApplicationProvider());

  Future<void> _fetchLoanApplication() async {
    try {
      String loanApplicationId = arguments["quoteId"].toString();

      LoanApplication? loanApplicationResponse = await loanApplicationRepository
          .fetchLoanApplication(loanApplicationId);

      if (loanApplicationResponse != null) {
        setState(() {
          isEditMode = loanApplicationResponse.estado != 3; // Vendida
          isFirstTime = false;
        });

        _applicationId = loanApplicationResponse.idAplicacion;
        unitDetailPageController.detailCompany.text =
            loanApplicationResponse.empresa;
        unitDetailPageController.detailIncomes.text =
            loanApplicationResponse.sueldo;
        unitDetailPageController.detailKindJob.text = "";
        unitDetailPageController.detailJobInDate.text =
            loanApplicationResponse.fechaIngreso;
        unitDetailPageController.detailDpi.text = loanApplicationResponse.dpi;
        unitDetailPageController.detailNit.text = loanApplicationResponse.nit;

        setState(() {
          isEditMode = loanApplicationResponse.estado != 3;
        });
      }
    } catch (e) {
      print('Failed to fetch loan application: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      unitDetailPageController.startController();
      _fetchLoanApplication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      sideBarList: const [],
      appBar: const CustomAppBarTitle(title: 'Detalle de cotización'),
      child: Form(
        key: _formKeyApplyQuote,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.heightSize),
            CustomInputWidget(
                enabled: isEditMode,
                validator: (value) => notEmptyFieldValidator(value),
                controller: unitDetailPageController.detailCompany,
                label: "Empresa",
                hintText: "Empresa",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                enabled: isEditMode,
                validator: (value) {
                  final isValidMinMonths = graterThanNumberValidator(value, 1);
                  final isValidMaxMonths =
                      lowerThanNumberValidator(value, 150000);
                  if (!isValidMinMonths) return '${Strings.incomesMax} 0.0';

                  if (isValidMaxMonths) return null;
                  return '${Strings.incomesMin} 150,000.00';
                },
                controller: unitDetailPageController.detailIncomes,
                label: "Sueldo",
                hintText: "Sueldo",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                enabled: isEditMode,
                validator: (value) => stringLengthValidator(value, 2, 50)
                    ? null
                    : Strings.kindOfJob,
                controller: unitDetailPageController.detailKindJob,
                label: "Puesto",
                hintText: "Puesto",
                prefixIcon: Icons.person_outline),
            CustomDatePicker(
              enabled: isEditMode,
              controller: unitDetailPageController.detailJobInDate,
              label: "Fecha Ingreso",
              hintText: "Fecha Ingreso",
              prefixIcon: Icons.date_range_outlined,
              validator: (value) {
                bool isDateValid = daysOldValidator(value.toString(), 2);
                if (!isDateValid) {
                  return "La fecha debe ser mayor 2 días";
                }
                if (value != null) return null;
                return "VALIDE CAMPOS";
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(actualYear - 60),
              lastDate: DateTime(actualYear + 1),
            ),
            CustomDatePicker(
              enabled: isEditMode,
              controller: unitDetailPageController.detailBirthday,
              label: "Fecha de nacimiento",
              hintText: "Fecha de nacimiento",
              prefixIcon: Icons.date_range_outlined,
              validator: (value) {
                bool isDateValid = yearsOldValidator(value.toString(), 2);
                if (!isDateValid) {
                  return "El cliente debe de ser mayor a 18 años";
                }
                if (value != null) return null;
                return "VALIDE CAMPOS";
              },
              initialDate: DateTime(actualYear - 1),
              firstDate: DateTime(actualYear - 90),
              lastDate: DateTime(actualYear),
            ),
            CustomInputWidget(
                enabled: isEditMode,
                validator: (value) {
                  final isValidDpi = dpiValidator(value);
                  if (!isValidDpi) {
                    return Strings.notValidDPI;
                  }
                  return null;
                },
                controller: unitDetailPageController.detailDpi,
                label: "DPI",
                hintText: "DPI",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                enabled: isEditMode,
                validator: (value) => nitValidation(value),
                controller: unitDetailPageController.detailNit,
                label: "NIT",
                hintText: "NIT",
                prefixIcon: Icons.person_outline),
            const SizedBox(height: Dimensions.heightSize),
            LogoUploadWidget(
                developerLogoController: unitDetailPageController.frontDpi,
                text: "DPI (Frente)",
                validator: (value) => null),
            LogoUploadWidget(
                developerLogoController: unitDetailPageController.reverseDpi,
                text: "DPI (Reverso)",
                validator: (value) => null),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                      text: "Aplicar a crédito",
                      onTap: () async {
                        if (_formKeyApplyQuote.currentState!.validate()) {
                          LoanApplication loanApplication = LoanApplication(
                            idCotizacion: arguments['quoteId'].toString(),
                            fotoDpiEnfrente: "linkFoto",
                            fotoDpiReverso: "linkFoto",
                            estado: 2, //Estado inicializada
                            empresa:
                                unitDetailPageController.detailCompany.text,
                            sueldo: unitDetailPageController.detailIncomes.text,
                            fechaIngreso:
                                unitDetailPageController.detailJobInDate.text,
                            dpi: unitDetailPageController.detailDpi.text,
                            nit: unitDetailPageController.detailNit.text,
                          );

                          try {
                            EasyLoading.showToast(Strings.loading);
                            if (isFirstTime) {
                              await loanApplicationRepository
                                  .submitLoanApplication(loanApplication);
                            } else {
                              await loanApplicationRepository
                                  .updateLoanApplication(loanApplication,
                                      _applicationId.toString());
                            }

                            unitDetailPageController.cleanController();
                            EasyLoading.showSuccess(
                                "Aplicación a crédito exitosa.");
                            Get.toNamed(RouterPaths.DASHBOARD_PAGE);
                          } catch (e) {
                            EasyLoading.showError(Strings.pleaseVerifyInputs);
                          } finally {
                            EasyLoading.dismiss();
                          }
                        } else {
                          EasyLoading.showError(Strings.pleaseVerifyInputs);
                        }
                      }),
                ),
                Expanded(
                  child: CustomButtonWidget(
                      text: Strings.goBack,
                      onTap: () {
                        Get.back(closeOverlays: true);
                      }),
                )
              ],
            ),
            const SizedBox(height: Dimensions.heightSize * 3),
          ],
        ),
      ),
    );
  }
}

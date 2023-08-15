import 'package:developer_company/data/implementations/loan_application_repository_impl.dart';
import 'package:developer_company/data/models/loan_application_model.dart';
import 'package:developer_company/data/providers/loan_application_provider.dart';
import 'package:developer_company/data/repositories/loan_application_repository.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/validations/dpi_validator.dart';
import 'package:developer_company/shared/validations/image_button_validator.dart';
import 'package:developer_company/shared/validations/nit_validation.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
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

  LoanApplicationRepository loanApplicationRepository =
      LoanApplicationRepositoryImpl(LoanApplicationProvider());

  Future<void> fetchLoanApplication() async {
    try {
      String loanApplicationId = arguments["quoteId"];

      LoanApplication? loanApplicationResponse = await loanApplicationRepository
          .fetchLoanApplication(loanApplicationId);

      if (loanApplicationResponse != null) {
        setState(() {
          isEditMode = loanApplicationResponse.estado != 4; // Vendida
        });
        // SHOULD BE FILL
        // IF ESTATUS IS Vendido only SHOW
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
                validator: (value) => notEmptyFieldValidator(value),
                controller: unitDetailPageController.detailIncomes,
                label: "Sueldo",
                hintText: "Sueldo",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                enabled: isEditMode,
                validator: (value) => notEmptyFieldValidator(value),
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
                if (value != null) return null;
                return "VALIDE CAMPOS";
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime(2100),
            ),
            CustomDatePicker(
              enabled: isEditMode,
              controller: unitDetailPageController.detailBirthday,
              label: "Fecha de nacimiento",
              hintText: "Fecha de nacimiento",
              prefixIcon: Icons.date_range_outlined,
              validator: (value) {
                if (value != null) return null;
                return "VALIDE CAMPOS";
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(1930),
              lastDate: DateTime(2100),
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
                validator: (value) => imageButtonValidator(value)),
            LogoUploadWidget(
                developerLogoController: unitDetailPageController.reverseDpi,
                text: "DPI (Reverso)",
                validator: (value) => imageButtonValidator(value)),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                      text: "Aplicar a crédito",
                      onTap: () async {
                        if (_formKeyApplyQuote.currentState!.validate()) {
                          LoanApplication loanApplication = LoanApplication(
                            idCotizacion: 5,
                            idCliente: null,
                            fotoDpiEnfrente: "linkFoto",
                            fotoDpiReverso: "linkFoto",
                            estado: 1,
                            idDetalleFiador: null,
                            empresa: "EmpresaX",
                            sueldo: 5000,
                            fechaIngreso: "2020-01-28",
                            dpi: 1254874512,
                            nit: 23658945,
                          );
                          try {
                            //? SHOULD BE PUT EP TO APPLY UNIT QUOTE;
                            EasyLoading.showToast(Strings.loading);
                            final successApplication =
                                await loanApplicationRepository
                                    .submitLoanApplication(loanApplication);

                            if (successApplication) {
                              EasyLoading.showSuccess(
                                  "Aplicación a crédito exitosa.");

                              Get.toNamed(RouterPaths.DASHBOARD_PAGE);
                              unitDetailPageController.cleanController();
                              return;
                            }
                            EasyLoading.showError(Strings.pleaseVerifyInputs);
                          } catch (e) {
                            EasyLoading.showError(Strings.pleaseVerifyInputs);
                          } finally {
                            EasyLoading.dismiss();
                          }

                          //! should be apply to credit in EP;
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

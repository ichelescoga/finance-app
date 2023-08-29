import 'package:developer_company/data/implementations/loan_application_repository_impl.dart';
import 'package:developer_company/data/models/loan_application_model.dart';
import 'package:developer_company/data/providers/loan_application_provider.dart';
import 'package:developer_company/data/repositories/loan_application_repository.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/validations/days_old_validator.dart';
import 'package:developer_company/shared/validations/dpi_validator.dart';
import 'package:developer_company/shared/validations/grater_than_number_validator.dart';
import 'package:developer_company/shared/validations/image_button_validator.dart';
import 'package:developer_company/shared/validations/lower_than_number_validator%20copy.dart';
import 'package:developer_company/shared/validations/nit_validation.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/string_length_validator.dart';
import 'package:developer_company/shared/validations/years_old_validator.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/date_picker.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDetailClient extends StatefulWidget {
  final String? loanApplicationId;
  final bool isEditMode;
  final Function(bool, String?) updateEditMode;

  const FormDetailClient(
      {Key? key,
      required this.loanApplicationId,
      required this.updateEditMode,
      this.isEditMode = true})
      : super(key: key);

  @override
  _FormDetailClientState createState() => _FormDetailClientState();
}

class _FormDetailClientState extends State<FormDetailClient> {
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  LoanApplicationRepository loanApplicationRepository =
      LoanApplicationRepositoryImpl(LoanApplicationProvider());

  int actualYear = DateTime.now().year;

  Future<void> _fetchLoanApplication() async {
    try {
      String? loanApplicationId = widget.loanApplicationId;

      if (loanApplicationId == null) {
        return;
      }

      LoanApplication? loanApplicationResponse = await loanApplicationRepository
          .fetchLoanApplication(loanApplicationId);

      if (loanApplicationResponse != null) {
        final newIdApplication = loanApplicationResponse.idAplicacion;

        // final loanStatus = loanApplicationResponse.estado;
        // final canEdit = !(loanStatus == 3 ||
        //         loanStatus == 6 ||
        //         loanStatus == 7) &&
        //     widget.isEditMode; //TODO: STUB ENHANCE LOGIC unit_status unitStatus

        // widget.updateEditMode(canEdit, false, newIdApplication);
        widget.updateEditMode(false, newIdApplication);

        unitDetailPageController.detailCompany.text =
            loanApplicationResponse.empresa;
        unitDetailPageController.detailIncomes.text =
            loanApplicationResponse.sueldo;
        unitDetailPageController.detailKindJob.text = loanApplicationResponse.puesto;
        unitDetailPageController.detailBirthday.text = loanApplicationResponse.fechaNacimiento;

        unitDetailPageController.detailJobInDate.text =
            loanApplicationResponse.fechaIngreso;
        unitDetailPageController.detailDpi.text = loanApplicationResponse.dpi;
        unitDetailPageController.detailNit.text = loanApplicationResponse.nit;

        setState(() {
          unitDetailPageController.frontDpi
              .updateLink(loanApplicationResponse.fotoDpiEnfrente);
          unitDetailPageController.reverseDpi
              .updateLink(loanApplicationResponse.fotoDpiReverso);
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
    return Column(
      children: [
        const SizedBox(height: Dimensions.heightSize),
        CustomInputWidget(
            enabled: widget.isEditMode,
            validator: (value) => notEmptyFieldValidator(value),
            controller: unitDetailPageController.detailCompany,
            label: "Empresa",
            hintText: "Empresa",
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
           onFocusChangeInput: (hasFocus) {
              if (!hasFocus) {
                unitDetailPageController.detailIncomes.text =
                    quetzalesCurrency(unitDetailPageController.detailIncomes.text);
              } 
            },
            enabled: widget.isEditMode,
            validator: (value) {
              final incomes = extractNumber(value!);

              final isValidMinMonths = graterThanNumberValidator(incomes, 1);
              final isValidMaxMonths = lowerThanNumberValidator(incomes, 150000);
              if (!isValidMinMonths) {
                return '${Strings.incomesMax} 0.0';
              }

              if (isValidMaxMonths) {
                return null;
              }
              return '${Strings.incomesMin} 150,000.00';
            },
            controller: unitDetailPageController.detailIncomes,
            label: "Sueldo",
            hintText: "Sueldo",
            keyboardType: TextInputType.number,
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            enabled: widget.isEditMode,
            validator: (value) =>
                stringLengthValidator(value, 2, 50) ? null : Strings.kindOfJob,
            controller: unitDetailPageController.detailKindJob,
            label: "Puesto",
            hintText: "Puesto",
            prefixIcon: Icons.person_outline),
        CustomDatePicker(
          enabled: widget.isEditMode,
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
          enabled: widget.isEditMode,
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
            enabled: widget.isEditMode,
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
            enabled: widget.isEditMode,
            validator: (value) => nitValidation(value),
            controller: unitDetailPageController.detailNit,
            label: "NIT",
            hintText: "NIT",
            prefixIcon: Icons.person_outline),
        const SizedBox(height: Dimensions.heightSize),
        LogoUploadWidget(
           icon: Icon(
              Icons.camera,
              color: Colors.white,
            ),
            enabled: widget.isEditMode,
            uploadImageController: unitDetailPageController.frontDpi,
            text: "DPI(Enfrente)",
            validator: (value) {
              if (!unitDetailPageController.frontDpi.needUpdate) {
                return null;
              }
              return imageButtonValidator(value,
                  validationText: Strings.dpiPhotoFrontRequired);
            }),
        LogoUploadWidget(
            icon: Icon(
              Icons.camera,
              color: Colors.white,
            ),
            enabled: widget.isEditMode,
            uploadImageController: unitDetailPageController.reverseDpi,
            text: "DPI(Reverso)",
            validator: (value) {
              if (!unitDetailPageController.reverseDpi.needUpdate) {
                return null;
              }
              return imageButtonValidator(value,
                  validationText: Strings.dpiPhotoReverseRequired);
            }),
      ],
    );
  }
}

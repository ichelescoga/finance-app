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

  @override
  void initState() {
    super.initState();
    unitDetailPageController.startController();
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
                validator: (value) => notEmptyFieldValidator(value),
                controller: unitDetailPageController.detailCompany,
                label: "Empresa",
                hintText: "Empresa",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => notEmptyFieldValidator(value),
                controller: unitDetailPageController.detailIncomes,
                label: "Sueldo",
                hintText: "Sueldo",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => notEmptyFieldValidator(value),
                controller: unitDetailPageController.detailKindJob,
                label: "Puesto",
                hintText: "Puesto",
                prefixIcon: Icons.person_outline),
            CustomDatePicker(
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
                      onTap: () {
                        if (_formKeyApplyQuote.currentState!.validate()) {
                          try {
                            // SHOULD BE PUT EP TO APPLY UNIT QUOTE;
                            EasyLoading.showToast(Strings.loading);
                            // print("PASSED 😉");
                            Get.toNamed(RouterPaths.DASHBOARD_PAGE);
                            unitDetailPageController.cleanController();
                          } catch (e) {
                            // print(e);
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

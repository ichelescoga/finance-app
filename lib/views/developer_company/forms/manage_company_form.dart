import "package:developer_company/data/implementations/upload_image_impl.dart";
import "package:developer_company/data/providers/upload_image.provider.dart";
import "package:developer_company/data/repositories/upload_image_repository.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import 'package:developer_company/controllers/manage_company_page_controller.dart';
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/upload_button_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ManageCompanyForm extends StatefulWidget {
  final bool enable;
  final String? companyId;

  const ManageCompanyForm({
    Key? key,
    required this.enable,
    this.companyId,
  }) : super(key: key);

  @override
  State<ManageCompanyForm> createState() => _ManageCompanyFormState();
}

class _ManageCompanyFormState extends State<ManageCompanyForm> {
  bool enable = false;
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());

  UploadImageRepository uploadImageRepository =
      UploadImageRepositoryImpl(UploadImageProvider());

  @override
  void initState() {
    super.initState();
    enable = widget.enable;
    if (widget.companyId != null) {
      //TODO: RETRIEVE DATA FOR EDITING COMPANY
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            CustomInputWidget(
              enabled: enable,
              controller: createCompanyPageController.developerCompanyName,
              label: "Nombre empresa",
              hintText: "Nombre Empresa",
              prefixIcon: Icons.business,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller:
                  createCompanyPageController.developerCompanyDescription,
              label: "Descripción",
              hintText: "Descripción de la empresa",
              prefixIcon: Icons.description,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller: createCompanyPageController.developerCompanyDeveloper,
              label: "Desarrollador",
              hintText: "Nombre del desarrollador",
              prefixIcon: Icons.person,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller: createCompanyPageController.developerCompanyNit,
              label: "NIT",
              hintText: "Número de Identificación Tributaria",
              prefixIcon: Icons.confirmation_number,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller: createCompanyPageController.developerCompanyAddress,
              label: "Dirección",
              hintText: "Dirección de la empresa",
              prefixIcon: Icons.location_on,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller:
                  createCompanyPageController.developerCompanyContactPhone,
              label: "Teléfono de Contacto",
              hintText: "Número de teléfono de contacto",
              prefixIcon: Icons.phone,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller:
                  createCompanyPageController.developerCompanyContactName,
              label: "Nombre de Contacto",
              hintText: "Nombre de la persona de contacto",
              prefixIcon: Icons.person_pin,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller:
                  createCompanyPageController.developerCompanySellManager,
              label: "Gerente de Ventas",
              hintText: "Nombre del gerente de ventas",
              prefixIcon: Icons.supervised_user_circle,
            ),
            CustomInputWidget(
              enabled: widget.enable,
              controller:
                  createCompanyPageController.developerCompanySellManagerPhone,
              label: "Teléfono del Gerente de Ventas",
              hintText: "Número de teléfono del gerente de ventas",
              prefixIcon: Icons.phone_android,
            ),
            LogoUploadWidget(
              text: "Logo",
              enabled: widget.enable,
              validator: (value) {
                if (value == null) {
                  return "Seleccione un logo para Proyecto";
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                      text: "Atrás",
                      onTap: () => Navigator.pop(context, false)),
                ),
                Expanded(
                  child: CustomButtonWidget(
                      color: AppColors.blueColor,
                      text: "Guardar",
                      onTap: () {}),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
          ],
        )
      ],
    );
  }
}

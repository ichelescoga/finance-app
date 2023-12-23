import "package:developer_company/data/implementations/company_repository_impl.dart";
// import "package:developer_company/data/implementations/upload_image_impl.dart";
// import "package:developer_company/data/models/company_model.dart";
import "package:developer_company/data/providers/company_provider.dart";
// import "package:developer_company/data/providers/upload_image.provider.dart";
import "package:developer_company/data/repositories/company_repository.dart";
// import "package:developer_company/data/repositories/upload_image_repository.dart";
import 'package:developer_company/controllers/manage_company_page_controller.dart';
import "package:developer_company/shared/validations/nit_validation.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/shared/validations/phone_validator.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/upload_button_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class ManageCompanyForm extends StatefulWidget {
  final bool enable;
  final int? companyId;

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

  CompanyRepository companyRepository =
      CompanyRepositoryImpl(CompanyProvider());

  _fetchCompanyById() async{
    final companyId = widget.companyId;
    if (companyId != null) {
      EasyLoading.show();
      final company = await companyRepository.getCompanyById(companyId);
      createCompanyPageController.updateCompanyValues(company);
      setState(() {
        createCompanyPageController.developerCompanyLogo.updateLink(company.logo);
      });

      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    enable = widget.enable;
    _fetchCompanyById();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputWidget(
          enabled: enable,
          controller: createCompanyPageController.developerCompanyName,
          label: "Nombre empresa",
          hintText: "Nombre Empresa",
          prefixIcon: Icons.business,
          validator: (value) => notEmptyFieldValidator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanyDescription,
          label: "Descripción",
          hintText: "Descripción de la empresa",
          prefixIcon: Icons.description,
          validator: (value) => notEmptyFieldValidator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanyDeveloper,
          label: "Desarrollador",
          hintText: "Nombre del desarrollador",
          prefixIcon: Icons.person,
          validator: (value) => notEmptyFieldValidator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanyNit,
          label: "NIT",
          hintText: "Número de Identificación Tributaria",
          prefixIcon: Icons.confirmation_number,
          validator: (value) => nitValidation(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanyAddress,
          label: "Dirección",
          hintText: "Dirección de la empresa",
          prefixIcon: Icons.location_on,
          validator: (value) => notEmptyFieldValidator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanyContactPhone,
          label: "Teléfono de Contacto",
          hintText: "Número de teléfono de contacto",
          prefixIcon: Icons.phone,
          validator: (value) => phone_validator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanyContactName,
          label: "Nombre de Contacto",
          hintText: "Nombre de la persona de contacto",
          prefixIcon: Icons.person_pin,
          validator: (value) => notEmptyFieldValidator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller: createCompanyPageController.developerCompanySellManager,
          label: "Gerente de Ventas",
          hintText: "Nombre del gerente de ventas",
          prefixIcon: Icons.supervised_user_circle,
          validator: (value) => notEmptyFieldValidator(value),
        ),
        CustomInputWidget(
          enabled: widget.enable,
          controller:
              createCompanyPageController.developerCompanySellManagerPhone,
          label: "Teléfono del Gerente de Ventas",
          hintText: "Número de teléfono del gerente de ventas",
          prefixIcon: Icons.phone_android,
          validator: (value) => phone_validator(value),
        ),
        LogoUploadWidget(
          uploadImageController:
              createCompanyPageController.developerCompanyLogo,
          text: "Logo",
          enabled: widget.enable,
          validator: (value) {
            if (value == null) {
              return "Seleccione un logo para Proyecto";
            }
            return null;
          },
        )
      ],
    );
  }
}

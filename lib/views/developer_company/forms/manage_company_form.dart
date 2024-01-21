import "package:developer_company/data/implementations/company_repository_impl.dart";
// import "package:developer_company/data/models/CDI/custom_image_model.dart";
import "package:developer_company/data/models/image_model.dart";
import "package:developer_company/data/providers/company_provider.dart";
import "package:developer_company/data/repositories/company_repository.dart";
import 'package:developer_company/controllers/manage_company_page_controller.dart';
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/utils/cdi_components.dart";
import "package:developer_company/utils/get_keyboard_type_from_string.dart";
import "package:developer_company/utils/selected_icon.dart";
import "package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/upload_button_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class ManageCompanyForm extends StatefulWidget {
  final bool enable;
  final int? companyId;
  final Map<String, TextEditingController> controllers;
  final Map<String, ImageToUpload> imageControllers;
  final List<dynamic> formCustomWidgets;

  const ManageCompanyForm({
    Key? key,
    required this.enable,
    required this.controllers,
    required this.formCustomWidgets,
    required this.imageControllers,
    this.companyId,
  }) : super(key: key);

  @override
  State<ManageCompanyForm> createState() => _ManageCompanyFormState();
}

class _ManageCompanyFormState extends State<ManageCompanyForm> {
  bool enable = false;
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());

  HttpAdapter http = HttpAdapter();

  CompanyRepository companyRepository =
      CompanyRepositoryImpl(CompanyProvider());

  List<dynamic> formWidgets = [];
  dynamic company = {};

  UnitDetailPageController asdf = UnitDetailPageController();

  _fetchCompanyById() async {
    final companyId = widget.companyId;
    formWidgets = widget.formCustomWidgets;
    if (companyId != null) {
      EasyLoading.show();
      final companyResult = await companyRepository.getCompanyById(companyId);
      company = companyResult;

      formWidgets.forEach((element) {
        element["defaultValue"] = company[element["bodyKey"]];
      });
      setState(() {});
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
      children: formWidgets.map((widgetEP) {
        String id = widgetEP["bodyKey"];

        //! IMAGE COMPONENT
        if (widgetEP["Type"] == CDIConstants.image) {
          ImageToUpload imageController = ImageToUpload(
            base64: null,
            needUpdate: widgetEP["defaultValue"] != null,
            link: "",
          );

          if (widgetEP["defaultValue"] != null) {
            imageController.updateLink(widgetEP["defaultValue"]);
          }

          widget.imageControllers[id] = imageController;
          return LogoUploadWidget(
              uploadImageController: imageController,
              text: widgetEP["Place_holder"],
              validator: (value) => null);
        }
        //! INPUT COMPONENT
        if (widgetEP["Type"] == CDIConstants.input) {
          TextEditingController controller = TextEditingController(
              text: widgetEP["defaultValue"] != null
                  ? widgetEP["defaultValue"]
                  : "");
          widget.controllers[id] = controller;
          return CustomInputWidget(
            controller: controller,
            label: widgetEP["Place_holder"],
            hintText: widgetEP["Place_holder"],
            keyboardType: getKeyboardTypeFromString(widgetEP["InputType"]),
            prefixIcon: selectedIcon(widgetEP["Icon"]),
          );
        }

        return Container();
      }).toList(),
    );
  }
}

import "package:developer_company/data/implementations/CDI/cdi_repository_impl.dart";
import "package:developer_company/data/implementations/company_repository_impl.dart";
import "package:developer_company/data/providers/CDI/cdi_provider.dart";
// import "package:developer_company/data/implementations/upload_image_impl.dart";
// import "package:developer_company/data/models/company_model.dart";
import "package:developer_company/data/providers/company_provider.dart";
import "package:developer_company/data/repositories/CDI/cdi_repository.dart";
// import "package:developer_company/data/providers/upload_image.provider.dart";
import "package:developer_company/data/repositories/company_repository.dart";
// import "package:developer_company/data/repositories/upload_image_repository.dart";
import 'package:developer_company/controllers/manage_company_page_controller.dart';
// import "package:developer_company/shared/validations/nit_validation.dart";
// import "package:developer_company/shared/validations/not_empty.dart";
// import "package:developer_company/shared/validations/phone_validator.dart";
import "package:developer_company/utils/selected_icon.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
// import "package:developer_company/widgets/upload_button_widget.dart";
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

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());
  // final List<dynamic> listWidgets = [];

  List<dynamic> formWidgets = [];

  _getFormCompany() async {
    final result = await cdiRepository.fetchCompanyTable();
    formWidgets = result;
  }

  _fetchCompanyById() async {
    final companyId = widget.companyId;
    if (companyId != null) {
      EasyLoading.show();
      final company = await companyRepository.getCompanyById(companyId);
      createCompanyPageController.updateCompanyValues(company);
      setState(() {
        createCompanyPageController.developerCompanyLogo
            .updateLink(company.logo);
      });

      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    enable = widget.enable;
    _fetchCompanyById();
    _getFormCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: formWidgets.map((widget) {
        TextEditingController controller = TextEditingController();
        print('manage_company_form 84  ${widget["Type"]}');
        if (widget["Type"] == "QTS_Input")
          return CustomInputWidget(
              controller: controller,
              label: widget["Place_holder"],
              hintText: widget["Place_holder"],
              prefixIcon: selectedIcon(widget["Icon"]));

        return Container();
      }).toList(),
    );
  }
}

// ignore_for_file: deprecated_member_use
// import 'package:developer_company/shared/resources/colors.dart';
// import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/controllers/manage_company_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/views/developer_company/forms/manage_company_form.dart';
// import 'package:developer_company/shared/resources/colors.dart';
// import 'package:developer_company/shared/resources/dimensions.dart';
// import 'package:developer_company/shared/utils/responsive.dart';
// import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
// import 'package:developer_company/widgets/custom_button_widget.dart';
// import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/layout.dart';
// import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());
  final GlobalKey<FormState> manageCompanyFormKey = GlobalKey<FormState>();

  String? companyId;
  int activeStep = 0;
  double circleRadius = 20;
  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments = Get.arguments;
    if (arguments["companyId"] != null) {
      companyId = arguments["companyId"].toString();
    }
  }

  _handleAddCompany() async {}

  _handleEditCompany() async {}

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Gestión empresas",
        ),
        child: Form(
          key: manageCompanyFormKey,
          child: Column(
            children: [
              ManageCompanyForm(
                enable: true,
                companyId: "0",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                        padding: EdgeInsets.zero,
                        text: "Atrás",
                        onTap: () => Navigator.pop(context, false)),
                  ),
                  const SizedBox(width: Dimensions.formSpaceBetweenButtons),
                  Expanded(
                      child: CustomButtonWidget(
                    padding: EdgeInsets.zero,
                    color: AppColors.blueColor,
                    text: "Guardar",
                    onTap: () {
                      if (manageCompanyFormKey.currentState!.validate()) {
                        companyId != null
                            ? _handleEditCompany()
                            : _handleAddCompany();
                      } else {
                        EasyLoading.showInfo(
                            "Por favor verifique que los campos sean validos.");
                      }
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: Dimensions.heightSize,
              ),
            ],
          ),
        ));
  }
}

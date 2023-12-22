// ignore_for_file: deprecated_member_use
// import 'package:developer_company/shared/resources/colors.dart';
// import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/controllers/manage_company_page_controller.dart';
import 'package:developer_company/views/developer_company/forms/manage_company_form.dart';
// import 'package:developer_company/shared/resources/colors.dart';
// import 'package:developer_company/shared/resources/dimensions.dart';
// import 'package:developer_company/shared/utils/responsive.dart';
// import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
// import 'package:developer_company/widgets/custom_button_widget.dart';
// import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/layout.dart';
// import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final _formKeyDeveloper = GlobalKey<FormState>();
  // final _formKeyProject = GlobalKey<FormState>();
  // final _formKeySells = GlobalKey<FormState>();
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());

  int activeStep = 0;
  double circleRadius = 20;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive responsive = Responsive.of(context);

    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Gestión empresas",
        ),
        child: ManageCompanyForm(
          enable: true,
        ));
  }
}

import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardClientPage extends StatefulWidget {
  const DashboardClientPage({Key? key}) : super(key: key);

  @override
  _DashboardClientPageState createState() => _DashboardClientPageState();
}

class _DashboardClientPageState extends State<DashboardClientPage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      onBackFunction: () {
        Get.overlayContext?.findRootAncestorStateOfType<NavigatorState>();
      },
      sideBarList: [],
      appBar: CustomAppBarSideBar(title: "Bienvenido"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.heightSize),
          CustomButtonWidget(
              text: "Mis inversiones",
              onTap: () => {},
              padding: const EdgeInsets.only(left: 0.0, right: 0.0)),
        ],
      ),
    );
  }
}


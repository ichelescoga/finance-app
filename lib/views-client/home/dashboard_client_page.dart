import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_client_paths.dart';
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
          buildButton("Mis Inversiones", RouterClientPaths.UNITS, {}),
        ],
      ),
    );
  }
}

Widget buildButton(String name, String route, Map<String, dynamic> params) {
  final spaceButton = SizedBox(height: Dimensions.heightSize);
  final defaultPadding = EdgeInsets.only(left: 0, right: 0);

  return Column(
    children: [
      spaceButton,
      CustomButtonWidget(
          text: name,
          onTap: () => Get.toNamed(route, arguments: params),
          padding: defaultPadding),
    ],
  );
}

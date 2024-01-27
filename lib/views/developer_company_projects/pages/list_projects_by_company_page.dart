import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/CDI/dynamic_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class _ListProjectsByCompanyState extends StatefulWidget {
  _ListProjectsByCompanyState({Key? key}) : super(key: key);

  @override
  __ListProjectsByCompanyStateState createState() =>
      __ListProjectsByCompanyStateState();
}

class __ListProjectsByCompanyStateState
    extends State<_ListProjectsByCompanyState> {

  final Map<String, dynamic> arguments = Get.arguments;
  final String COMPANY_ENTITY = "1";  
  String PROJECT_ENDPOINT = "orders/v1/getProjectsByCompany?id=DATA_ID";

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    final dataId = arguments['dataId'];
    PROJECT_ENDPOINT.replaceFirst("DATA_ID", dataId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
        tittlePage: "Proyectos",
        showDeleteAction: false,
        navigationIcon: Icons.business,
        route: RouterPaths.MANAGE_COMPANY_PAGE,
        entity: COMPANY_ENTITY,
        endpointRoute: PROJECT_ENDPOINT,
        filterBoxLabel: "Empresas",
        filterHintLabel: "Empresas");
  }
}

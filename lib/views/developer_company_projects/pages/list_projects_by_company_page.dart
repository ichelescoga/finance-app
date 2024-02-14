import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/CDI/dynamic_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ListProjectsByCompanyState extends StatefulWidget {
  const ListProjectsByCompanyState({Key? key}) : super(key: key);

  @override
  _ListProjectsByCompanyStateState createState() =>
      _ListProjectsByCompanyStateState();
}

class _ListProjectsByCompanyStateState
    extends State<ListProjectsByCompanyState> {
  final Map<String, dynamic> arguments = Get.arguments;
  final String COMPANY_ENTITY = "2";
  String PROJECT_ENDPOINT = "orders/v1/getProjectsByCompany?id=DATA_ID";

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    final dataId = arguments['dataId'];
    PROJECT_ENDPOINT =
        PROJECT_ENDPOINT.replaceFirst("DATA_ID", dataId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
      editEndpoint: "",
      addEndpoint: "",
      removeEndpoint: "",
      getByIdEndpoint: "",
      titlePage: "Proyectos",
      route: RouterPaths.ASSIGN_PROJECT_TO_COMPANY_PAGE,
      entity: COMPANY_ENTITY,
      listEndpointRoute: PROJECT_ENDPOINT,
      filterBoxLabel: "Empresas",
      filterHintLabel: "Empresas",
    );
  }
}

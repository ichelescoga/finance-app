import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/widgets/CDI/dynamic_table_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";

class listCompaniesToProjectsPage extends StatefulWidget {
  const listCompaniesToProjectsPage({Key? key}) : super(key: key);

  @override
  _listCompaniesToProjectsPageState createState() => _listCompaniesToProjectsPageState();
}

class _listCompaniesToProjectsPageState extends State<listCompaniesToProjectsPage> {
  final String COMPANY_ENTITY = "1";
  String COMPANY_ENDPOINT = "orders/v1/getCompanies";

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
      editEndpoint: "",
        addEndpoint: "",
        removeEndpoint: "",
        getByIdEndpoint: "",
        titlePage: "Proyectos 1",
        showDeleteAction: false,
        navigationIcon: Icons.business,
        route: RouterPaths.LIST_PROJECTS_BY_COMPANY_PAGE,
        entity: COMPANY_ENTITY,
        listEndpointRoute: COMPANY_ENDPOINT,
        filterBoxLabel: "Empresas",
        filterHintLabel: "Empresas");
  }
}

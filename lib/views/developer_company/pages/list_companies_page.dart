import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/CDI/dynamic_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListCompanies extends StatefulWidget {
  const ListCompanies({Key? key}) : super(key: key);

  @override
  _ListCompaniesState createState() => _ListCompaniesState();
}

class _ListCompaniesState extends State<ListCompanies> {
  final String COMPANY_ENTITY = "1";
  String COMPANY_ENDPOINT = "orders/v1/getCompanies";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
        titlePage: "Empresas",
        editEndpoint: "",
        addEndpoint: "",
        removeEndpoint: "",
        getByIdEndpoint: "",
        route: RouterPaths.MANAGE_COMPANY_PAGE,
        entity: COMPANY_ENTITY,
        listEndpointRoute: COMPANY_ENDPOINT,
        filterBoxLabel: "Empresas",
        filterHintLabel: "Empresas");
  }
}

import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/CDI/dynamic_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CDIListPage extends StatefulWidget {
  const CDIListPage({Key? key}) : super(key: key);

  @override
  _CDIListPageState createState() => _CDIListPageState();
}

class _CDIListPageState extends State<CDIListPage> {
  final Map<String, dynamic> arguments = Get.arguments;

  String pageTitle = "";
  String entityId = "";
  String listEndpoint = "";
  String editEndpoint = "";
  String addEndpoint = "";
  String removeEndpoint = "";
  String getByIdEndpoint = "";

  @override
  void initState() {
    super.initState();
    pageTitle = arguments["label"].toString();
    entityId = arguments["entityId"].toString();
    listEndpoint = arguments["listEndpoint"].toString();
    editEndpoint = arguments["editEndpoint"].toString();
    addEndpoint = arguments["addEndpoint"].toString();
    removeEndpoint = arguments["removeEndpoint"].toString();
    getByIdEndpoint = arguments["getByIdEndpoint"].toString();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
        showAddAction: arguments["addEndpoint"] != null,
        showDeleteAction: arguments["removeEndpoint"] != null,
        showActionIcon: arguments["editEndpoint"] != null,
        titlePage: pageTitle,
        getByIdEndpoint: getByIdEndpoint,
        route: RouterPaths.MANAGE_CDI_PAGE,
        editEndpoint: editEndpoint,
        addEndpoint: addEndpoint,
        removeEndpoint: removeEndpoint,
        entity: entityId,
        listEndpointRoute: listEndpoint,
        filterBoxLabel: pageTitle,
        filterHintLabel: "Buscar");
  }
}

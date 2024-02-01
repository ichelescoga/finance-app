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
  String endpoint = "";

  @override
  void initState() {
    super.initState();
    pageTitle = arguments["label"].toString();
    entityId = arguments["id"].toString();
    endpoint = arguments["endpoint"].toString();

  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
        tittlePage: pageTitle,
        route: RouterPaths.MANAGE_CDI_PAGE,
        entity: entityId,
        endpointRoute: endpoint,
        filterBoxLabel: pageTitle,
        filterHintLabel: "Buscar");
  }
}

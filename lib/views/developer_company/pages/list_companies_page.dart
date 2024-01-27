import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
// import 'package:developer_company/data/models/company_model.dart';
// import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
// import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
// import 'package:developer_company/data/repositories/company_repository.dart';
// import 'package:developer_company/shared/resources/colors.dart';
// import 'package:developer_company/shared/resources/dimensions.dart';
// import 'package:developer_company/shared/routes/router_paths.dart';
// import 'package:developer_company/widgets/CDI/dynamic_form.dart';
import 'package:developer_company/widgets/CDI/dynamic_table_widget.dart';
// import 'package:developer_company/widgets/app_bar_sidebar.dart';
// import 'package:developer_company/widgets/data_table.dart';
// import 'package:developer_company/widgets/delete_company_dialog.dart';
// import 'package:developer_company/widgets/filter_box.dart';
// import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ListCompanies extends StatefulWidget {
  const ListCompanies({Key? key}) : super(key: key);

  @override
  _ListCompaniesState createState() => _ListCompaniesState();
}

class _ListCompaniesState extends State<ListCompanies> {
  // CompanyRepository companyProvider = CompanyRepositoryImpl(CompanyProvider());
  CDIRepository cdiProvider = CDIRepositoryImpl(CDIProvider());
  List<dynamic> companies = [];
  List<dynamic> filteredCompanies = [];

  // _getCompanies() async {
  //   String COMPANY_ENDPOINT = "orders/v1/getCompanies";
  //   final tempCompanies = await cdiProvider.fetchDataList(COMPANY_ENDPOINT);

  //   companies = tempCompanies;
  //   filteredCompanies = tempCompanies;
  // }

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());
  final String COMPANY_ENTITY = "1";
  String COMPANY_ENDPOINT = "orders/v1/getCompanies";
  List<dynamic> columnsData = [];

  // _getFormCompany() async {
  //   EasyLoading.show();
  //   filteredCompanies.clear();
  //   companies.clear();
  //   final result = await cdiRepository.fetchDataTable(COMPANY_ENTITY);
  //   columnsData = result
  //       .where((e) => e["ShowInList"] == true || e["ShoInList"] == "true")
  //       .toList();
  //   await _getCompanies();
  //   EasyLoading.dismiss();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    // _getFormCompany();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  // _handleManageCompany(int? companyId) async {
  //   final needUpdateListCompanies = await Get.toNamed(
  //       RouterPaths.MANAGE_COMPANY_PAGE,
  //       arguments: {"companyId": companyId});
  //   if (needUpdateListCompanies) {
  //     _getFormCompany();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return dynamicTableWidget(
        route: RouterPaths.MANAGE_COMPANY_PAGE,
        entity: COMPANY_ENTITY,
        endpointRoute: COMPANY_ENDPOINT,
        filterBoxLabel: "Empresas",
        filterHintLabel: "Empresas");
  }
}

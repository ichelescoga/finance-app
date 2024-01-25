import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
// import 'package:developer_company/data/models/company_model.dart';
// import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
// import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
// import 'package:developer_company/data/repositories/company_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/delete_company_dialog.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
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

  _getCompanies() async {
    String COMPANY_ENDPOINT = "orders/v1/getCompanies";
    final tempCompanies = await cdiProvider.fetchDataList(COMPANY_ENDPOINT);

    companies = tempCompanies;
    filteredCompanies = tempCompanies;
  }

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());

  List<dynamic> columnsData = [];

  _getFormCompany() async {
    EasyLoading.show();
    final result = await cdiRepository.fetchCompanyTable();
    print(
        'list_companies_page number of line 50  _getFormCompany  ${result} for choose the name');

    columnsData = result
        .where((e) => e["ShowInList"] == true || e["ShoInList"] == "true")
        .toList();

    // formWidgets = result;
    // setState(() {
    // });
    await _getCompanies();
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getFormCompany();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  _handleManageCompany(int? companyId) async {
    final needUpdateListCompanies = await Get.toNamed(
        RouterPaths.MANAGE_COMPANY_PAGE,
        arguments: {"companyId": companyId});
    if (needUpdateListCompanies) {
      _getCompanies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarSideBar(
          title: "Empresas",
          rightActions: [
            IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: AppColors.softMainColor,
                  size: Dimensions.topIconSizeH,
                ),
                onPressed: () {
                  _handleManageCompany(null);
                })
          ],
        ),
        child: Column(
          children: [
            FilterBox(
              label: "Buscar Empresas",
              hint: "Buscar",
              elements: companies,
              isLoading: false,
              handleFilteredData: (List<dynamic> data) =>
                  setState(() => filteredCompanies = data),
            ),
            if (columnsData.length > 0)
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CustomDataTable(
                    columns: [...columnsData]
                        .map((e) => e["HintText"].toString())
                        .toList()
                      ..add(""),
                    elements: filteredCompanies
                        .asMap()
                        .map((index, element) => MapEntry(
                            index,
                            DataRow(
                              cells: [...columnsData]
                                  .map((e) =>
                                      DataCell(Text(element[e["bodyKey"]].toString())))
                                  .toList()
                                ..add(
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () =>
                                                _handleManageCompany(
                                                    element["id"]),
                                            icon: Icon(Icons.edit_square)),
                                        IconButton(
                                            onPressed: () => _dialogDeleteCompany(context, element[columnsData[0]["bodyKey"]].toString(), element["id"]),
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                ),
                              color: index % 2 == 0
                                  ? MaterialStateProperty.all<Color>(
                                      AppColors.lightColor)
                                  : MaterialStateProperty.all<Color>(
                                      AppColors.lightSecondaryColor),
                            )))
                        .values
                        .toList(),
                  )),
          ],
        ));
  }

  _dialogDeleteCompany(BuildContext context, String name, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          child: DeleteCompanyDialog(
            companyName: name,
            companyId: id,
          ),
        );
      },
    ).then((value) {
      if (value == true) {
        _getCompanies();
        return;
      }
    });
  }
}


//  DataCell(Row(
//                                 children: [
//                                   IconButton(
//                                       onPressed: () => _handleManageCompany(
//                                           element.companyId),
//                                       icon: Icon(Icons.edit_square)),
//                                   IconButton(
//                                       onPressed: () => _dialogDeleteCompany(
//                                           context, element),
//                                       icon: Icon(Icons.delete))
//                                 ],
//                               ))
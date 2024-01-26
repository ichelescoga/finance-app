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

class dynamicTable extends StatefulWidget {
  const dynamicTable({Key? key}) : super(key: key);

  @override
  _dynamicTableState createState() => _dynamicTableState();
}

class _dynamicTableState extends State<dynamicTable> {
  CDIRepository cdiProvider = CDIRepositoryImpl(CDIProvider());
  List<dynamic> data = [];
  List<dynamic> filteredData = [];

  getData() async {
    String COMPANY_ENDPOINT = "orders/v1/getCompanies";
    final tempData = await cdiProvider.fetchDataList(COMPANY_ENDPOINT);

    data = tempData;
    filteredData = tempData;
  }

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());

  List<dynamic> columnsData = [];

  getFormData() async {
    EasyLoading.show();
    filteredData.clear();
    data.clear();
    final String COMPANY_ENTITY = "1";
    final result = await cdiRepository.fetchDataTable(COMPANY_ENTITY);
    columnsData = result
        .where((e) => e["ShowInList"] == true || e["ShoInList"] == "true")
        .toList();
    await getData();
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFormData();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  _handleManageData(int? id) async {
    final needUpdateListCompanies = await Get.toNamed(
        RouterPaths.MANAGE_COMPANY_PAGE,
        arguments: {"dataId": id});
    if (needUpdateListCompanies) {
      getFormData();
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
                  _handleManageData(null);
                })
          ],
        ),
        child: Column(
          children: [
            FilterBox(
              label: "Buscar Empresas",
              hint: "Buscar",
              elements: data,
              isLoading: false,
              handleFilteredData: (List<dynamic> data) =>
                  setState(() => filteredData = data),
            ),
            if (columnsData.length > 0)
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CustomDataTable(
                    columns: [...columnsData]
                        .map((e) => e["HintText"].toString())
                        .toList()
                      ..add(""),
                    elements: filteredData
                        .asMap()
                        .map((index, element) => MapEntry(
                            index,
                            DataRow(
                              cells: [...columnsData]
                                  .map((e) => DataCell(
                                      Text(element[e["bodyKey"]].toString())))
                                  .toList()
                                ..add(
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () =>
                                                _handleManageData(
                                                    element["id"]),
                                            icon: Icon(Icons.edit_square)),
                                        IconButton(
                                            onPressed: () =>
                                                _dialogDeleteCompany(
                                                    context,
                                                    element[columnsData[0]
                                                            ["bodyKey"]]
                                                        .toString(),
                                                    element["id"]),
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
        getData();
        return;
      }
    });
  }
}

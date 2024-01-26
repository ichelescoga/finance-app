import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/delete_company_dialog.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class dynamicTable extends StatefulWidget {
  final String route;
  final String entity;
  final String endpointRoute;
  final String filterBoxLabel;
  final String filterHintLabel;


  const dynamicTable(
      {Key? key,
      required this.route,
      required this.entity,
      required this.endpointRoute,
      required this.filterBoxLabel,
      required this.filterHintLabel,
      })
      : super(key: key);

  @override
  _dynamicTableState createState() => _dynamicTableState();
}

class _dynamicTableState extends State<dynamicTable> {
  CDIRepository cdiProvider = CDIRepositoryImpl(CDIProvider());
  List<dynamic> data = [];
  List<dynamic> filteredData = [];

  getData() async {
    final tempData = await cdiProvider.fetchDataList(widget.entity);
    data = tempData;
    filteredData = tempData;
  }

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());

  List<dynamic> columnsData = [];

  getFormData() async {
    EasyLoading.show();
    filteredData.clear();
    data.clear();
    final result = await cdiRepository.fetchDataTable(widget.entity);
    columnsData = result
        .where((e) => e["ShowInList"] == true || e["ShowInList"] == "true")
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
    final needUpdateListData =
        await Get.toNamed(widget.route, arguments: {"dataId": id});
    if (needUpdateListData) {
      getFormData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterBox(
          label: widget.filterBoxLabel,
          hint: widget.filterHintLabel,
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
                                        onPressed: () => _handleManageData(
                                            element["id"]),
                                        icon: Icon(Icons.edit_square)),
                                    IconButton(
                                        onPressed: () =>
                                            _dialogDeleteDataById(
                                                context,
                                                element[columnsData[0]
                                                        ["HintText"]!]
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
    );
  }

  _dialogDeleteDataById(BuildContext context, String name, int id) {
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

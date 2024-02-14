import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/delete_company_dialog.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class dynamicTableWidget extends StatefulWidget {
  final String route;
  final String entity;
  final String listEndpointRoute;
  final String editEndpoint;
  final String addEndpoint;
  final String removeEndpoint;
  final String getByIdEndpoint;
  final String filterBoxLabel;
  final String filterHintLabel;
  final bool showActionIcon;
  final bool showDeleteAction;
  final bool showAddAction;
  final IconData navigationIcon;
  final String titlePage;

  const dynamicTableWidget(
      {Key? key,
      required this.route,
      required this.entity,
      required this.listEndpointRoute,
      required this.editEndpoint,
      required this.addEndpoint,
      required this.removeEndpoint,
      required this.getByIdEndpoint,
      required this.filterBoxLabel,
      required this.filterHintLabel,
      required this.titlePage,
      this.showActionIcon = true,
      this.showDeleteAction = true,
      this.showAddAction = true,
      this.navigationIcon = Icons.edit_square})
      : super(key: key);

  @override
  _dynamicTableWidgetState createState() => _dynamicTableWidgetState();
}

class _dynamicTableWidgetState extends State<dynamicTableWidget> {
  CDIRepository cdiProvider = CDIRepositoryImpl(CDIProvider());
  List<dynamic> data = [];
  List<dynamic> filteredData = [];

  getData() async {
    final tempData = await cdiProvider.fetchDataList(widget.listEndpointRoute);
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

  handleManageData(int? id) async {
    final needUpdateListData = await Get.toNamed(widget.route, arguments: {
      "dataId": id,
      "entityId": widget.entity,
      "editEndpoint": widget.editEndpoint,
      "addEndpoint": widget.addEndpoint,
      "principalLabel": widget.titlePage,
      "getByIdEndpoint": widget.getByIdEndpoint
    });
    if (needUpdateListData) {
      getFormData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      sideBarList: [],
      appBar: CustomAppBarSideBar(
        title: widget.titlePage,
        rightActions: [
          if (widget.showAddAction)
            IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: AppColors.softMainColor,
                  size: Dimensions.topIconSizeH,
                ),
                onPressed: () => handleManageData(null))
        ],
      ),
      child: Column(
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
                                      if (widget.showActionIcon)
                                        IconButton(
                                            onPressed: () =>
                                                handleManageData(element["id"]),
                                            icon: Icon(widget.navigationIcon)),
                                      if (widget.showDeleteAction)
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
      ),
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

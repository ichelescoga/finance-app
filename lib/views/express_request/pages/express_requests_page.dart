import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:developer_company/views/express_request/controller/express_request_controller.dart';

class ExpressRequestPage extends StatefulWidget {
  const ExpressRequestPage({Key? key}) : super(key: key);

  @override
  State<ExpressRequestPage> createState() => _ExpressRequestPageState();
}

class _ExpressRequestPageState extends State<ExpressRequestPage> {
  late ExpressRequestController controller;
  late Responsive responsive;

  final List<SideBarItem> sideBarList = [];
  final user = container.read(userProvider);

  void retrieveData() async {
    try {
      EasyLoading.showToast(Strings.loading);
      await controller.fetchUnitProjects();
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        Get.put(ExpressRequestController(int.parse(user.project.projectId)));
    controller.cleanData;
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive.of(context);
    return Layout(
        sideBarList: sideBarList,
        appBar: CustomAppBarSideBar(
          title: "Cotización express",
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterBox(
                elements: controller.projectUnits,
                handleFilteredData: controller.setFilterData,
                isLoading: false,
                hint: "Unidades",
                label: "Unidades"),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => DataTable(
                    showCheckboxColumn: false,
                    headingRowHeight: responsive.hp(6),
                    headingRowColor: MaterialStateProperty.all<Color>(
                        AppColors.secondaryMainColor),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Unidad',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Estado',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Precio de venta',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                    rows: controller.filteredProjectUnits
                        .asMap()
                        .map((index, element) {
                          final priceFormatted =
                              quetzalesCurrency(element.salePrice);
                          return MapEntry(
                              index,
                              DataRow(
                                onSelectChanged: (value) async {
                                  if (!isAvailableForQuote(element.estadoId)) {
                                    // unitStatus unit_status vendida
                                    EasyLoading.showInfo(
                                        "No se puede generar cotización para unidad en estado ${getUnitStatus(element.estadoId)}");
                                  } else {
                                    Get.toNamed(
                                        RouterPaths.EXPRESS_QUOTE_DETAIL_PAGE,
                                        arguments: {
                                          'isEditing': false,
                                          'idQuote': null,
                                          'projectId': element.projectId,
                                          'unitName': element.unitName,
                                          'unitStatus': element.estadoId,
                                          'salePrice': element.salePrice,
                                          'finalSellPrice': element.salePrice,
                                          'unitId': element.unitId
                                        });
                                  }
                                },
                                cells: [
                                  DataCell(Container(
                                    constraints:
                                        BoxConstraints(maxWidth: Get.width / 3),
                                    child: Text(element.unitName),
                                  )),
                                  DataCell(Container(
                                    child:
                                        Text(getUnitStatus(element.estadoId)),
                                  )),
                                  DataCell(Container(
                                    child: Text(priceFormatted),
                                  )),
                                ],
                                color: index % 2 == 0
                                    ? MaterialStateProperty.all<Color>(
                                        AppColors.lightColor)
                                    : MaterialStateProperty.all<Color>(
                                        AppColors.lightSecondaryColor),
                              ));
                        })
                        .values
                        .toList())),
              ),
            ),
          ],
        ));
  }
}

import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:developer_company/global_state/providers/client_provider_state.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class UnitQuotePage extends ConsumerStatefulWidget {
  const UnitQuotePage({Key? key}) : super(key: key);

  @override
  ConsumerState<UnitQuotePage> createState() => _UnitQuotePageState();
}

class _UnitQuotePageState extends ConsumerState<UnitQuotePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ProjectRepository projectRepository =
      ProjectRepositoryImpl(ProjectProvider());

  List<Unit> projectUnits = [];
  List<Unit> filteredProjectUnits = [];
  final user = container.read(userProvider);

  final List<SideBarItem> sideBarList = [
    // {
    //   'icon': Icons.business,
    //   'title': 'Cotización de unidad',
    //   'route': RouterPaths.UNIT_QUOTE_PAGE,
    // },
    // {
    //   'icon': Icons.business,
    //   'title': 'Aplicación a crédito',
    //   'route': RouterPaths.CREDIT_APPLICATION_PAGE,
    // },
  ];

  final List<String> overviews = [
    "Semana actual",
    "Semana pasada",
    "Mes pasado",
  ];

  final List<String> overviewText = [
    "Rendimiento esta semana",
    "Rendimiento semana pasada",
    "Rendimiento Mes pasado",
  ];

  final List<double> overviewPercentage = [64, 40, 90];

  final List<Color> overviewColors = [
    AppColors.mainColor,
    AppColors.greyColor,
    AppColors.softMainColor
  ];

  final indexTab = 0.obs;
  final showFirst = false.obs;

  void _fetchUnitProjects(String projectId) async {
    try {
      List<Project> project =
          await projectRepository.fetchUnitsByProject(int.tryParse(projectId)!);
      setState(() {
        projectUnits = project[0].units;
        filteredProjectUnits = project[0].units;
      });
    } catch (e) {
      // print('Project fetching failed: $e');
    }
  }

  void retrieveData() async {
    try {
      EasyLoading.showToast(Strings.loading);
      final projectId = user.project.projectId;
      _fetchUnitProjects(projectId);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void cleanSelectedContactToClient() {
    ref.read(selectedContactToClientProviderState.notifier).state = null;
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  void dispose() {
    super.dispose();
    cleanSelectedContactToClient();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Layout(
      onBackFunction: () {
        cleanSelectedContactToClient();
        Get.offAllNamed(RouterPaths.DASHBOARD_PAGE);
      },
      sideBarList: sideBarList,
      appBar:
          const CustomAppBarSideBar(title: "Creación de solicitud de crédito"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBox(
              elements: projectUnits,
              handleFilteredData: (List<Unit> data) {
                setState(() => filteredProjectUnits = data);
              },
              isLoading: false,
              hint: "Unidades",
              label: "Unidades"),
          // HERE DASHBOARD OF CREATE QUOTE
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
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
                  rows: filteredProjectUnits
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
                                      RouterPaths.UNIT_QUOTE_DETAIL_PAGE,
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
                                  child: Text(getUnitStatus(element.estadoId)),
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
                      .toList()),
            ),
          ),
          const SizedBox(height: Dimensions.heightSize),
        ],
      ),
    );
  }

  createIconTopProfile() {
    return IconButton(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(60.0),
        child: Image.asset(
          'assets/icondef.png',
        ),
      ),
      onPressed: () {},
    );
  }
}

class ChartData {
  ChartData(this.month, this.sales1, this.sales2, this.sales3);
  final String month;
  final double sales1;
  final double sales2;
  final double sales3;
}

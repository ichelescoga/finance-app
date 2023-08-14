import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/company_repository.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UnitQuotePage extends StatefulWidget {
  const UnitQuotePage({Key? key}) : super(key: key);

  @override
  State<UnitQuotePage> createState() => _UnitQuotePageState();
}

class _UnitQuotePageState extends State<UnitQuotePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final CompanyRepository companyRepository =
      CompanyRepositoryImpl(CompanyProvider());

  final ProjectRepository projectRepository =
      ProjectRepositoryImpl(ProjectProvider());

  List<Unit> _projectUnits = [];

  final List<Map<String, dynamic>> sideBarList = [
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

  Future<int> _fetchCompany() async {
    try {
      List<Company> companies = await companyRepository.fetchCompanies();
      return companies[0].companyId;
    } catch (e) {
      return 0;
    }
  }

  void _fetchUnitProjects(int companyId) async {
    try {
      List<Project> project =
          await projectRepository.fetchUnitsByProject(companyId);
      // print(project[0].units);
      setState(() {
        _projectUnits = project[0].units;
      });
      // print(project[0].units[0].unitName);
    } catch (e) {
      // Handle project fetching failure or show error message
      // print('Project fetching failed: $e');
    }
  }

  void retrieveData() async {
    try {
      EasyLoading.show(status: "Cargando");
      final companyId = await _fetchCompany();
      print(companyId);
      _fetchUnitProjects(companyId);
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Layout(
      sideBarList: sideBarList,
      appBar:
          const CustomAppBarSideBar(title: "Creación de Solicitud de crédito"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  rows: _projectUnits
                      .asMap()
                      .map((index, element) => MapEntry(
                          index,
                          DataRow(
                            onSelectChanged: (value) async {
                              Get.toNamed(RouterPaths.UNIT_QUOTE_DETAIL_PAGE,
                                  arguments: {
                                    'isEditing': false,
                                    'idQuote': null,
                                    'projectId': element.projectId,
                                    'unitName': element.unitName,
                                    'unitStatus': element.estadoId,
                                    'salePrice': element.salePrice,
                                    'unitId': element.unitId
                                  });
                            },
                            cells: [
                              DataCell(Container(
                                constraints:
                                    BoxConstraints(maxWidth: Get.width / 3),
                                child: Text(element.unitName),
                              )),
                              DataCell(Container(
                                child: Text(unitStatus[element.estadoId]!),
                              )),
                              DataCell(Container(
                                child: Text('Q. ${element.salePrice}'),
                              )),
                            ],
                            color: index % 2 == 0
                                ? MaterialStateProperty.all<Color>(
                                    AppColors.lightColor)
                                : MaterialStateProperty.all<Color>(
                                    AppColors.lightSecondaryColor),
                          )))
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

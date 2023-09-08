import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/company_repository.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/views/quotes/controllers/quote_consult_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class QuoteUnitStatusPage extends StatefulWidget {
  const QuoteUnitStatusPage({Key? key}) : super(key: key);

  @override
  State<QuoteUnitStatusPage> createState() => _QuoteUnitStatusPageState();
}

class _QuoteUnitStatusPageState extends State<QuoteUnitStatusPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QuoteConsultPageController quoteConsultPageController =
      Get.put(QuoteConsultPageController());

  final CompanyRepository companyRepository =
      CompanyRepositoryImpl(CompanyProvider());

  final ProjectRepository projectRepository =
      ProjectRepositoryImpl(ProjectProvider());
  List<Unit> _projectUnits = [];

  final List<Map<String, dynamic>> sideBarList = [
    // {
    //   'icon': Icons.business,
    //   'title': 'Consulta de cotizaciones',
    //   'route': RouterPaths.QUOTE_CONSULT_PAGE,
    // },
    // {
    //   'icon': Icons.business,
    //   'title': 'Tipo de unidades',
    //   'route': RouterPaths.QUOTE_STATS_PAGE,
    // },
    // {
    //   'icon': Icons.business,
    //   'title': 'Estado de unidades',
    //   'route': RouterPaths.QUOTE_UNIT_STATUS_PAGE,
    // }
  ];

  List<Item> items = [
    Item(icon: Icons.home, title: 'Unidad', isSelected: true),
  ];

  void selectItem(int index) {
    setState(() {
      for (int i = 0; i < items.length; i++) {
        if (i == index) {
          items[i].isSelected = true;
        } else {
          items[i].isSelected = false;
        }
      }
    });
  }

  Future<int> _fetchCompany() async {
    EasyLoading.show(status: "Cargando...");
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
      print(project[0].units);
      setState(() {
        _projectUnits = project[0].units;
      });
      print(project[0].units[0].unitName);
    } catch (e) {
      // Handle project fetching failure or show error message
      print('Project fetching failed: $e');
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

  late Item itemSelected;
  @override
  void initState() {
    super.initState();

    retrieveData();
    quoteConsultPageController.startController();
    itemSelected = items.first;
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return Layout(
        appBar: const CustomAppBarSideBar(title: "Consulta de Cotizaciones"),
        sideBarList: sideBarList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.heightSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        selectItem(items.indexOf(item));
                        quoteConsultPageController.update();
                        itemSelected = item;
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: item.isSelected
                              ? AppColors.softMainColor
                              : AppColors.secondaryMainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: Dimensions.heightSize),
            const Text(
              "Estado de unidad",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: Dimensions.heightSize * 0.5,
            ),
            const SizedBox(height: Dimensions.heightSize),
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
                              onSelectChanged: (value) {
                                Get.toNamed(RouterPaths.UNIT_DETAIL_PAGE,
                                    arguments: {
                                      'isEditing': false,
                                      'projectId': "${element.projectId}",
                                      'unitId': '${element.unitId}',
                                      'unitName': element.unitName,
                                      'unitStatus': element.estadoId,
                                      'salePrice': element.salePrice,
                                      'finalSellPrice': element.salePrice
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
                                  child: Text(
                                      quetzalesCurrency(element.salePrice)),
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
            )
          ],
        ));
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

class Item {
  final IconData icon;
  final String title;
  bool isSelected;

  Item({required this.icon, required this.title, this.isSelected = false});
}

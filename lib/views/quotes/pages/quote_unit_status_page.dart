import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/views/quotes/controllers/quote_consult_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:developer_company/widgets/top_selector_screen.dart';
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

  final ProjectRepository projectRepository =
      ProjectRepositoryImpl(ProjectProvider());
  List<Unit> _projectUnits = [];

  final user = container.read(userProvider);

  final List<SideBarItem> sideBarList = [
    // {
    //   'icon': Icons.business,
    //   'title': 'Consulta de cotizaciones',
    //   'route': RouterPaths.QUOTE_CONSULT_PAGE,
    // }
  ];

  List<Item> options = [
    Item(id: "units", icon: Icons.home, title: 'Unidad', isSelected: true),
    // Item(
    //     id: "byClient",
    //     icon: Icons.document_scanner,
    //     title: 'Cotizaciones',
    //     isSelected: false)
  ];

  // void selectItem(int index) {
  //   setState(() {
  //     for (int i = 0; i < items.length; i++) {
  //       if (i == index) {
  //         items[i].isSelected = true;
  //       } else {
  //         items[i].isSelected = false;
  //       }
  //     }
  //   });
  // }

  void _fetchUnitProjects(String projectId) async {
    try {
      List<Project> project =
          await projectRepository.fetchUnitsByProject(int.tryParse(projectId)!);
      print("hello world ${project[0].units}");
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
      final projectId = user.project.projectId;
      _fetchUnitProjects(projectId);
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
    itemSelected = options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        appBar: const CustomAppBarSideBar(title: "Consulta de Cotizaciones"),
        sideBarList: sideBarList,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.heightSize),
            TopSelectorScreen(
                items: options,
                onTapOption: ((p0) {
                  setState(() {
                    itemSelected = p0;
                    quoteConsultPageController.update();
                  });
                })),
            const SizedBox(height: Dimensions.heightSize),
            if (itemSelected.id == "units") unitsQuotes(context),
            if (itemSelected.id == "byClient") Text("By Client :)")
          ],
        ));
  }

  unitsQuotes(BuildContext context) {
    return Column(
      children: [
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
              child: CustomDataTable(
                columns: ["Unidad", "Estado", "Precio de Venta"],
                elements: _projectUnits
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
                              child: Text(quetzalesCurrency(element.salePrice)),
                            )),
                          ],
                          color: index % 2 == 0
                              ? MaterialStateProperty.all<Color>(
                                  AppColors.lightColor)
                              : MaterialStateProperty.all<Color>(
                                  AppColors.lightSecondaryColor),
                        )))
                    .values
                    .toList(),
              )),
        )
      ],
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

class Item {
  final IconData icon;
  final String title;
  bool isSelected;
  final String id;

  Item(
      {required this.id,
      required this.icon,
      required this.title,
      this.isSelected = false});
}

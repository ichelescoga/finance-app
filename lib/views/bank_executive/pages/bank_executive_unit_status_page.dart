import 'package:developer_company/views/quotes/controllers/quote_consult_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/views/quotes/pages/quote_unit_status_page.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankExecutiveUnitStatusPage extends StatefulWidget {
  const BankExecutiveUnitStatusPage({Key? key}) : super(key: key);

  @override
  State<BankExecutiveUnitStatusPage> createState() =>
      _BankExecutiveUnitStatusPageState();
}

class _BankExecutiveUnitStatusPageState
    extends State<BankExecutiveUnitStatusPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QuoteConsultPageController quoteConsultPageController =
      Get.put(QuoteConsultPageController());

  final List<SideBarItem> sideBarList = [
    SideBarItem(
      id: 'Ejecutivo bancario',
      icon: Icons.business,
      title: 'Ejecutivo bancario',
      route: RouterPaths.BANK_EXECUTIVE_PAGE,
    ),
    SideBarItem(
      id: 'Consultas ejecutivo',
      icon: Icons.business,
      title: 'Consultas ejecutivo',
      route: RouterPaths.BANK_EXECUTIVE_STATS_PAGE,
    ),
    SideBarItem(
      id: 'Estado de unidades',
      icon: Icons.business,
      title: 'Estado de unidades',
      route: RouterPaths.BANK_EXECUTIVE_UNIT_STATUS_PAGE,
    ),
  ];

  List<Item> items = [
    Item(
        id:"as", icon: Icons.check_circle_outline, title: 'Aprobados', isSelected: true),
    Item(id:"as", icon: Icons.fact_check, title: 'Cotizados'),
    Item(id:"as",icon: Icons.av_timer_outlined, title: 'Pendientes'),
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

  late Item itemSelected;
  @override
  void initState() {
    super.initState();
    quoteConsultPageController.startController();
    itemSelected = items.first;
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return WillPopScope(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.openEndDrawer();
                } else {
                  scaffoldKey.currentState!.openDrawer();
                }
              },
            ),
            actions: [createIconTopProfile()],
            elevation: 0.25,
            backgroundColor: AppColors.BACKGROUND,
            title: const Text(
              'Consulta de Cotizaciones',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          drawer: SideBarWidget(
              listTiles: sideBarList, onPressedProfile: () => Get.back()),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: responsive.wp(5), right: responsive.wp(5)),
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
                              padding: EdgeInsets.all(10),
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
                                  SizedBox(width: 2),
                                  Text(
                                    item.title,
                                    style: TextStyle(
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
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showCheckboxColumn: false,
                        headingRowHeight: 50,
                        headingRowColor: MaterialStateProperty.all<Color>(
                            AppColors.secondaryMainColor),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Cliente',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                            ),
                          ),
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
                                textAlign: TextAlign.left,
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
                                textAlign: TextAlign.left,
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
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(8, (index) {
                          return DataRow(
                            onSelectChanged: (value) {
                              print('Unidad ${index + 1}');
                              Get.toNamed(RouterPaths.CLIENT_DETAIL_PAGE);
                            },
                            cells: [
                              DataCell(
                                Container(
                                  width: 150,
                                  child: Text('Cliente ${index + 1}'),
                                ),
                              ),
                              DataCell(
                                Container(
                                  width: 150,
                                  child: Text('Unidad ${index + 1}'),
                                ),
                              ),
                              DataCell(
                                Container(
                                  width: 150,
                                  child: Text(''),
                                ),
                              ),
                              DataCell(
                                Container(
                                  width: 150,
                                  child: Text(''),
                                ),
                              ),
                            ],
                            color: index % 2 == 0
                                ? MaterialStateProperty.all<Color>(
                                    AppColors.lightColor)
                                : MaterialStateProperty.all<Color>(
                                    AppColors.lightSecondaryColor),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Get.back(closeOverlays: true);
          return false;
        });
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

// class Item {
//   final IconData icon;
//   final String title;
//   bool isSelected;

//   Item({required this.icon, required this.title, this.isSelected = false});
// }

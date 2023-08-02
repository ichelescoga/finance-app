import 'package:developer_company/quotes/controllers/quote_consult_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routhes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuoteUnitStatusPage extends StatefulWidget {
  const QuoteUnitStatusPage({Key? key}) : super(key: key);

  @override
  State<QuoteUnitStatusPage> createState() => _QuoteUnitStatusPageState();
}


class _QuoteUnitStatusPageState extends State<QuoteUnitStatusPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QuoteConsultPageController quoteConsultPageController = Get.put(QuoteConsultPageController());

  List<Item> items = [
    Item(icon: Icons.home, title: 'Unidad', isSelected: true),
    Item(icon: Icons.people, title: 'Cliente'),
    Item(icon: Icons.work, title: 'Ejecutivo'),
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
            actions: [
              createIconTopProfile()
            ],
            elevation: 0.25,
            backgroundColor: AppColors.BACKGROUND,
            title: Text(
              'Consulta de Cotizaciones',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          drawer: createDrawer(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
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
                            color: item.isSelected ? AppColors.softMainColor : AppColors.secondaryMainColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item.icon,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
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
                  Text(
                    "Estado de unidad",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  Center(
                    child: DataTable(
                      showCheckboxColumn: false,
                      headingRowHeight: responsive.hp(6),
                      headingRowColor: MaterialStateProperty.all<Color>(AppColors.secondaryMainColor),
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
                      rows: List.generate(8, (index) {
                        return DataRow(
                          onSelectChanged: (value){
                            print('Unidad ${index + 1}');
                            Get.toNamed(RouterPaths.UNIT_DETAIL_PAGE);
                          },
                          cells: [
                            DataCell(Container(
                              width: (Get.width/5) - 10,
                              child: Text('Unidad ${index + 1 }'),
                            )),
                            DataCell(Container(
                              width: (Get.width/5) - 10,
                              child: Text(''),
                            )),
                            DataCell(Container(
                              width: (Get.width/5) - 10,
                              child: Text(''),
                            )),
                          ],
                            color: index % 2 == 0 ? MaterialStateProperty.all<Color>(AppColors.lightColor) : MaterialStateProperty.all<Color>(AppColors.lightSecondaryColor)

                        );
                      }),
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
        child:Image.asset(
          'assets/icondef.png',
        ),
      ),
      onPressed: () {

      },
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: Container(
        color: AppColors.BACKGROUND,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: profileWidget(),
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.business,
                color: Colors.black87,
              ),
              title: const Text(
                "Consulta de cotizaciones",
              ),
              onTap: () {
                Get.offNamed(RouterPaths.QUOTE_CONSULT_PAGE);
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.business,
                color: Colors.black87,
              ),
              title: const Text(
                "Tipo de unidades",
              ),
              onTap: () {
                Get.offNamed(RouterPaths.QUOTE_STATS_PAGE);
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.business,
                color: Colors.black87,
              ),
              title: const Text(
                "Estado de unidades",
              ),
              onTap: () {
                Get.offNamed(RouterPaths.QUOTE_UNIT_STATUS_PAGE);
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  profileWidget() {
    return InkWell(
      onTap: () {
        Get.back();
        //actionToAccount(x, member);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5 * 3,
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: Image.asset(
              'assets/icondef.png',
            ),
          ),
          title: Text(
            "User",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.1),
          ),
          subtitle: Text(
            "${Strings.appName}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final IconData icon;
  final String title;
  bool isSelected;

  Item({required this.icon, required this.title, this.isSelected = false});
}
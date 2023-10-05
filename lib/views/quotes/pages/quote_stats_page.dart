import 'package:developer_company/views/quotes/controllers/quote_consult_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class QuoteStatsPage extends StatefulWidget {
  const QuoteStatsPage({Key? key}) : super(key: key);

  @override
  State<QuoteStatsPage> createState() => _QuoteStatsPageState();
}

class _QuoteStatsPageState extends State<QuoteStatsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QuoteConsultPageController quoteConsultPageController =
      Get.put(QuoteConsultPageController());

  final List<SideBarItem> sideBarList = [
    SideBarItem(
        id: 'Consulta de cotizaciones',
        icon: Icons.business,
        title: 'Consulta de cotizaciones',
        route: RouterPaths.QUOTE_CONSULT_PAGE),
    SideBarItem(
        id: 'Tipo de unidades',
        icon: Icons.business,
        title: 'Tipo de unidades',
        route: RouterPaths.QUOTE_STATS_PAGE),
    SideBarItem(
        id: 'Estado de unidades',
        icon: Icons.business,
        title: 'Estado de unidades',
        route: RouterPaths.QUOTE_UNIT_STATUS_PAGE),
  ];

  final List<String> overviews = [
    "Vendidas",
    "Cotizadas",
    "Contactos",
  ];

  final List<String> overviewText = [
    "Meta de ventas",
    "Meta de ventas",
    "Rendimiento Mes pasado",
  ];

  final List<double> overviewPercentage = [64, 40, 100];

  final List<Color> overviewColors = [
    AppColors.mainColor,
    AppColors.greyColor,
    AppColors.softMainColor
  ];

  final indexTab = 0.obs;
  final showFirst = false.obs;

  bool _isAguinaldoSwitched = false;
  bool _isBonoSwitched = false;

  @override
  void initState() {
    super.initState();
    quoteConsultPageController.startController();
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
                  SwitchListTile(
                    title: const Text(
                      'Semana actual',
                      style: TextStyle(color: Colors.black),
                    ),
                    value: _isAguinaldoSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        _isAguinaldoSwitched = value;
                        _isBonoSwitched = false;
                      });
                    },
                    activeColor: AppColors.softMainColor,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text(
                      'Semana pasada',
                      style: TextStyle(color: Colors.black),
                    ),
                    value: _isBonoSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        _isBonoSwitched = value;
                        _isAguinaldoSwitched = false;
                      });
                    },
                    activeColor: AppColors.softMainColor,
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  SizedBox(
                    width: Get.width,
                    height: responsive.hp(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => InkWell(
                                    onTap: () {
                                      indexTab.value = index;
                                      showFirst.value = true;
                                      setState(() {});

                                      if (index > 0) {
                                        //refresh();
                                      }

                                      if (index == 2) {
                                        //x.setFirstThreeMonth();
                                      }

                                      Future.delayed(
                                          const Duration(milliseconds: 2500),
                                          () {
                                        showFirst.value = false;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: Get.width / 30, bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          if (index == indexTab.value)
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 5,
                                              offset: const Offset(0.5, 1.5),
                                            ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: index == indexTab.value
                                            ? Colors.white
                                            : AppColors.lightColor,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (index == indexTab.value)
                                            const CircleAvatar(
                                              backgroundColor:
                                                  AppColors.mainColor,
                                              radius: 3,
                                            ),
                                          if (index == indexTab.value)
                                            const SizedBox(width: 5),
                                          Text(
                                            overviews[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize:
                                                    index == indexTab.value
                                                        ? 15
                                                        : 14,
                                                fontWeight:
                                                    index == indexTab.value
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                color: index == indexTab.value
                                                    ? Colors.black
                                                    : Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: overviews.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  Center(
                    child: CircularPercentIndicator(
                      radius: 70.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: overviewPercentage[indexTab.value] / 100,
                      center: Text(
                        "${overviewPercentage[indexTab.value]}.0%",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "Meta de ventas",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: overviewColors[indexTab.value],
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Cantidad / Monto",
                    style: TextStyle(color: Colors.black),
                  ),
                  indexTab.value == 2
                      ? SfCircularChart(
                          title: ChartTitle(text: ''),
                          legend: Legend(isVisible: false),
                          series: <PieSeries<ChartData2, String>>[
                            PieSeries<ChartData2, String>(
                              dataSource: [
                                ChartData2('Product A', 60),
                                ChartData2('Product B', 40),
                              ],
                              xValueMapper: (ChartData2 data, _) =>
                                  data.product,
                              yValueMapper: (ChartData2 data, _) => data.sales,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            ),
                          ],
                        )
                      : SfCartesianChart(
                          title: ChartTitle(text: 'Lead optimizations'),
                          legend: Legend(isVisible: false),
                          series: <StackedColumnSeries>[
                            StackedColumnSeries<ChartData, String>(
                                dataSource: [
                                  ChartData('Jan', 10, 20, 30),
                                  ChartData('Feb', 20, 30, 10),
                                  ChartData('Mar', 30, 10, 20),
                                  ChartData('Apr', 15, 25, 35),
                                  ChartData('May', 25, 35, 15),
                                ],
                                xValueMapper: (ChartData sales, _) =>
                                    sales.month,
                                yValueMapper: (ChartData sales, _) =>
                                    sales.sales1,
                                name: 'Product A',
                                color: AppColors.blueColor),
                            StackedColumnSeries<ChartData, String>(
                                dataSource: [
                                  ChartData('Jan', 20, 10, 30),
                                  ChartData('Feb', 30, 20, 10),
                                  ChartData('Mar', 10, 30, 20),
                                  ChartData('Apr', 25, 15, 35),
                                  ChartData('May', 35, 25, 15),
                                ],
                                xValueMapper: (ChartData sales, _) =>
                                    sales.month,
                                yValueMapper: (ChartData sales, _) =>
                                    sales.sales2,
                                name: 'Product B',
                                color: AppColors.softMainColor),
                          ],
                          primaryXAxis: CategoryAxis(),
                        ),
                  const SizedBox(height: Dimensions.heightSize),
                  GestureDetector(
                    child: Center(
                      child: Container(
                        height: 50.0,
                        width: Get.width / 2,
                        decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius))),
                        child: Center(
                          child: Text(
                            "Detalle",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: Dimensions.heightSize),
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

class ChartData {
  ChartData(this.month, this.sales1, this.sales2, this.sales3);
  final String month;
  final double sales1;
  final double sales2;
  final double sales3;
}

class ChartData2 {
  final String product;
  final double sales;

  ChartData2(this.product, this.sales);
}

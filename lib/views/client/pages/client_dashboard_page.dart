import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ClientDashboardPage extends StatefulWidget {
  const ClientDashboardPage({Key? key}) : super(key: key);

  @override
  State<ClientDashboardPage> createState() => _ClientDashboardPageState();
}

class _ClientDashboardPageState extends State<ClientDashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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

  final List<double> overviewPercentage = [
    64,
    40,
    90
  ];

  final List<Color> overviewColors = [
    AppColors.mainColor,
    AppColors.greyColor,
    AppColors.softMainColor
  ];

  final indexTab = 0.obs;
  final showFirst = false.obs;

  @override
  void initState() {
    super.initState();
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
            elevation: 0.25,
            backgroundColor: AppColors.BACKGROUND,
            title: Text(
              'Cliente',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                                      Future.delayed(const Duration(milliseconds: 2500), () {
                                        showFirst.value = false;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(right: Get.width / 30, bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          if (index == indexTab.value)
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          if (index == indexTab.value)
                                            const CircleAvatar(
                                              backgroundColor: AppColors.mainColor,
                                              radius: 3,
                                            ),
                                          if (index == indexTab.value)
                                            const SizedBox(width: 5),
                                          Text(
                                            overviews[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: index == indexTab.value ? 15 : 14,
                                                fontWeight: index == indexTab.value
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
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: new Text(
                        "${overviewText[indexTab.value]}",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: overviewColors[indexTab.value],
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  SfCartesianChart(
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
                          xValueMapper: (ChartData sales, _) => sales.month,
                          yValueMapper: (ChartData sales, _) => sales.sales1,
                          name: 'Product A',
                          color: AppColors.blueColor
                      ),
                      StackedColumnSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Jan', 20, 10, 30),
                            ChartData('Feb', 30, 20, 10),
                            ChartData('Mar', 10, 30, 20),
                            ChartData('Apr', 25, 15, 35),
                            ChartData('May', 35, 25, 15),
                          ],
                          xValueMapper: (ChartData sales, _) => sales.month,
                          yValueMapper: (ChartData sales, _) => sales.sales2,
                          name: 'Product B',
                          color: AppColors.softMainColor
                      ),
                    ],
                    primaryXAxis: CategoryAxis(),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          "Ofertas de bancos",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RouterPaths.CLIENT_BANK_OFFERS_PAGE);
                    },
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          "Avances de creditos",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RouterPaths.CLIENT_CREDIT_ADVANCE_PAGE);
                    },
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
        child:Image.asset(
          'assets/icondef.png',
        ),
      ),
      onPressed: () {

      },
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
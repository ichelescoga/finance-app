import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/permission_level.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/AuthorizationWrapper.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> sideBarList = [
    {
      'icon': Icons.business,
      'title': 'Empresa Desarrolladora',
      'route': RouterPaths.QUOTE_CONSULT_PAGE,
    },
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

  final spaceButton = SizedBox(height: Dimensions.heightSize);
  final defaultPadding = EdgeInsets.only(left: 0, right: 0);

  Future askPermission() async {
    await Permission.manageExternalStorage.request();
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      return;
    }
    if (await Permission.storage.isRestricted) {
      return;
    }
    if (status.isGranted) {}
  }

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Layout(
      onBackFunction: () {
        Get.overlayContext?.findRootAncestorStateOfType<NavigatorState>();
      },
      sideBarList: const [],
      appBar: CustomAppBarSideBar(title: "Aplicación Financiera"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: responsive.hp(2)),
          AuthorizationWrapper(
            requestAction: PermissionLevel.dashboardAddDevelopmentCard,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: Get.width,
              height: 120,
              child: SizedBox(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouterPaths.CREATE_COMPANY_PAGE);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 5),
                      padding: const EdgeInsets.only(
                          left: 20, right: 32, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            //spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: const Text(
                              "No se encontraron empresas desarrolladoras",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "Haz clic aquí para crear una nueva empresa desarrolladora",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AuthorizationWrapper(
            requestAction: PermissionLevel.analystCreditByClient,
            child: Column(
              children: [
                const SizedBox(height: Dimensions.heightSize),
                CustomButtonWidget(
                    text: "Aprobaciones de crédito",
                    onTap: () =>
                        Get.toNamed(RouterPaths.ANALYST_CREDITS_BY_CLIENT_PAGE),
                    padding: const EdgeInsets.only(left: 0.0, right: 0.0)),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.heightSize),
          AuthorizationWrapper(
            requestAction: PermissionLevel.dashboardAddAdvisersCard,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: Get.width,
              height: 120,
              child: SizedBox(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouterPaths.CREATE_ADVISER_PAGE);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 5),
                      padding: const EdgeInsets.only(
                          left: 20, right: 32, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            //spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: const Text(
                              "No se encontraron asesores",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "Haz clic aquí para crear un nuevo asesor",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimensions.heightSize),
          AuthorizationWrapper(
            requestAction:
                PermissionLevel.dashboardAddExecutiveAndFinancialCard,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: Get.width,
              height: 120,
              child: SizedBox(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouterPaths.FINANCIAL_ENTITY_CREATION_PAGE);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 5),
                      padding: const EdgeInsets.only(
                          left: 20, right: 32, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            //spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: const Text(
                              "No se encontraron entidades financieras y ejecutivos",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "Haz clic aquí para crear una nueva entidad financiera y ejecutivo.",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AuthorizationWrapper(
              requestAction: PermissionLevel.dashboardAddQuoteButton,
              child: Column(
                children: [
                  spaceButton,
                  CustomButtonWidget(
                    text: "Creación de solicitud de crédito",
                    onTap: () => Get.toNamed(RouterPaths.UNIT_QUOTE_PAGE),
                    padding: defaultPadding,
                  ),
                ],
              )),
          const SizedBox(height: Dimensions.heightSize),
          AuthorizationWrapper(
            requestAction: PermissionLevel.dashboardQueryQuoteButton,
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: const Center(
                  child: Text(
                    "Consulta de cotizaciones por unidad",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed(RouterPaths.QUOTE_UNIT_STATUS_PAGE);
              },
            ),
          ),
          AuthorizationWrapper(
            requestAction: PermissionLevel.adviserCreditsApprovedAndReserved,
            child: Column(
              children: [
                spaceButton,
                CustomButtonWidget(
                    text: "Créditos Aprobados",
                    onTap: () => Get.toNamed(
                        RouterPaths.ADVISER_CREDITS_RESERVED_APPROVED),
                    padding: defaultPadding),
              ],
            ),
          ),
          AuthorizationWrapper(
            requestAction: PermissionLevel.marketingMaintenance,
            child: Column(
              children: [
                spaceButton,
                CustomButtonWidget(
                    text: "Mercadeo",
                    onTap: () => Get.toNamed(
                        RouterPaths.MARKETING_MAINTENANCE_ALBUMS,
                        arguments: {"isWatchMode": false}),
                    padding: defaultPadding),
              ],
            ),
          ),

          // TODO REMOVE ME
          // VideoCard(
          //     autoPlay: true,
          //     looping: true,
          //     videoUrl: "https://www.youtube.com/watch?v=N211yi0cJJI",
          //     showFavorite: true,
          //     description: "Hello World",
          //     initialFavorite: true,
          //     onFavoriteChanged: (bool hey) {}),

          const SizedBox(height: Dimensions.heightSize),
          AuthorizationWrapper(
            requestAction: PermissionLevel.dashboardExecutiveButton,
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: const Center(
                  child: Text(
                    "Ejecutivo bancario",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed(RouterPaths.BANK_EXECUTIVE_PAGE);
              },
            ),
          ),
          const SizedBox(height: Dimensions.heightSize),
          AuthorizationWrapper(
            requestAction: PermissionLevel.dashboardClientButton,
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: const Center(
                  child: Text(
                    "Cliente",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed(RouterPaths.CLIENT_DASHBOARD_PAGE);
              },
            ),
          ),
          const SizedBox(height: Dimensions.heightSize),
          AuthorizationWrapper(
              requestAction: PermissionLevel.dashboardReport,
              child: Column(
                children: [
                  const Text("Reportes",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: Text(
                        "${overviewText[indexTab.value]} ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: overviewColors[indexTab.value],
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const SizedBox(height: Dimensions.heightSize),
                  const SizedBox(height: Dimensions.heightSize),
                ],
              ))
        ],
      ),
    );
  }
}

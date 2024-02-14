import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/permission_level.dart';
// import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/AuthorizationWrapper.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<SideBarItem> sideBarList = [
    SideBarItem(
      requestAction: PermissionLevel.sideBarMarketing,
      id: "marketing",
      icon: Icons.insert_emoticon_sharp,
      title: 'Material Audio Visual',
      route: RouterPaths.MARKETING_CARROUSEL_ALBUMS,
    ),
    SideBarItem(
      requestAction: PermissionLevel.sideBarContacts,
      id: "contacts",
      icon: Icons.contacts,
      title: 'Contactos',
      route: RouterPaths.QUICK_CONTACT_LIST_PAGE,
    )
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

  final List<Map<String, String?>> cdi = [
    {
      "entityId": "1",
      "label": "Empresas",
      "listEndpoint": "orders/v1/getCompanies",
      "editEndpoint": "orders/v1/editCompany",
      "addEndpoint": "orders/v1/addCompany",
      "removeEndpoint": "orders/v1/getCompanies",
      "getByIdEndpoint": "orders/v1/getCompanyById",
    },
    {
      "entityId": "2",
      "label": "Proyectos",
      "listEndpoint": "orders/v1/getProjectsByCompany",
      "editEndpoint": "orders/v1/editProyect",
      "addEndpoint": "orders/v1/addProyect",
      "removeEndpoint": "orders/v1/deleteProyect",
      "getByIdEndpoint": "orders/v1/getProjectById",
    },
    {
      "entityId": "7",
      "label": "Unidades",
      "listEndpoint": "orders/v1/getTypes",
      "editEndpoint": null,
      "addEndpoint": "orders/v1/addType",
      "removeEndpoint": null,
      "getByIdEndpoint": null,
    },
    // {
    //   "entityId": "4",
    //   "label": "Unidades",
    //   "listEndpoint": "orders/v1/getTypesByProyect/4",
    //   "editEndpoint": null,
    //   "addEndpoint": "orders/v1/addType",
    //   "removeEndpoint": null,
    //   "getByIdEndpoint": null,
    // },
    // {
    //   "entityId": "5",
    //   "label": "Unidades",
    //   "listEndpoint": "orders/v1/getTypesByProyect/5",
    //   "editEndpoint": null,
    //   "addEndpoint": "orders/v1/addType",
    //   "removeEndpoint": null,
    //   "getByIdEndpoint": null,
    // },
  ];

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
    // Responsive responsive = Responsive.of(context);
    return Layout(
      onBackFunction: () {
        Get.overlayContext?.findRootAncestorStateOfType<NavigatorState>();
      },
      sideBarList: sideBarList,
      appBar: CustomAppBarSideBar(title: "Aplicación Financiera"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    text: "Material Audio Visual",
                    onTap: () => Get.toNamed(
                        RouterPaths.MARKETING_MAINTENANCE_ALBUMS,
                        arguments: {"isWatchMode": false}),
                    padding: defaultPadding),
              ],
            ),
          ),
          AuthorizationWrapper(
            requestAction: PermissionLevel.discountsByQuote,
            child: Column(
              children: [
                spaceButton,
                CustomButtonWidget(
                    text: "Descuentos",
                    onTap: () => Get.toNamed(
                        RouterPaths.DISCOUNTS_BY_QUOTE_PAGE,
                        arguments: {"isWatchMode": false}),
                    padding: defaultPadding),
              ],
            ),
          ),
          // AuthorizationWrapper(
          //   requestAction: PermissionLevel.manageCompany,
          //   child: Column(
          //     children: [
          //       spaceButton,
          //       CustomButtonWidget(
          //           text: "Empresas",
          //           onTap: () => Get.toNamed(RouterPaths.LIST_COMPANIES_PAGE),
          //           padding: defaultPadding),
          //     ],
          //   ),
          // ),
          // AuthorizationWrapper(
          //   requestAction: PermissionLevel.manageCompany,
          //   child: Column(
          //     children: [
          //       spaceButton,
          //       CustomButtonWidget(
          //           text: "Proyectos",
          //           onTap: () =>
          //               Get.toNamed(RouterPaths.LIST_COMPANY_PROJECTS_PAGE),
          //           padding: defaultPadding),
          //     ],
          //   ),
          // ),
          ...cdi
              .map((e) => AuthorizationWrapper(
                    requestAction: PermissionLevel.list_cdi,
                    child: Column(
                      children: [
                        spaceButton,
                        CustomButtonWidget(
                            text: e["label"].toString(),
                            onTap: () => Get.toNamed(RouterPaths.LIST_CDI_PAGE,
                                    arguments: {
                                      "entityId": e["entityId"],
                                      "label": e["label"],
                                      "listEndpoint": e["listEndpoint"],
                                      "editEndpoint": e["editEndpoint"],
                                      "addEndpoint": e["addEndpoint"],
                                      "removeEndpoint": e["removeEndpoint"],
                                      "getByIdEndpoint": e["getByIdEndpoint"],
                                    }),
                            padding: defaultPadding),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

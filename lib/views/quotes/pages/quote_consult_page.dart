import 'package:developer_company/views/quotes/controllers/quote_consult_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuoteConsultPage extends StatefulWidget {
  const QuoteConsultPage({Key? key}) : super(key: key);

  @override
  State<QuoteConsultPage> createState() => _QuoteConsultPageState();
}

class _QuoteConsultPageState extends State<QuoteConsultPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QuoteConsultPageController quoteConsultPageController =
      Get.put(QuoteConsultPageController());

  final List<SideBarItem> sideBarList = [
    SideBarItem(
      id:'Consulta de cotizaciones',
      icon: Icons.business,
      title: 'Consulta de cotizaciones',
      route: RouterPaths.QUOTE_CONSULT_PAGE,
    ),
    SideBarItem(
      id:'Tipo de unidades',
      icon: Icons.business,
      title: 'Tipo de unidades',
      route: RouterPaths.QUOTE_STATS_PAGE,
    ),
    SideBarItem(
      id:'Estado de unidades',
      icon: Icons.business,
      title: 'Estado de unidades',
      route: RouterPaths.QUOTE_UNIT_STATUS_PAGE,
    ),
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

  @override
  void initState() {
    super.initState();
    quoteConsultPageController.startController();
    quoteConsultPageController.status.text = 'En planos';
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
            listTiles: sideBarList,
            onPressedProfile: () => Get.back(),
          ),
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
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/logo_test.png',
                            width: responsive.wp(30),
                          ),
                          Text('Logo Desarrollador')
                        ],
                      ),
                      SizedBox(
                          width: responsive
                              .wp(10)), // Add spacing between the images
                      Column(
                        children: [
                          Image.asset(
                            'assets/logo_test.png',
                            width: responsive.wp(30),
                          ),
                          Text('Logo proyecto')
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Estado de unidades",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  DropdownButtonFormField<String>(
                    value: quoteConsultPageController.status.text,
                    style: CustomStyle.textStyle,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Estado del proyecto",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: AppColors.lightColor,
                      hintStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        quoteConsultPageController.status.text = newValue!;
                      });
                    },
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        child: Row(
                          children: const [
                            Icon(Icons.design_services),
                            SizedBox(width: 10),
                            Text("En planos"),
                          ],
                        ),
                        value: "En planos",
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: const [
                            Icon(Icons.construction),
                            SizedBox(width: 10),
                            Text("En construcción"),
                          ],
                        ),
                        value: "En construcción",
                      ),
                      DropdownMenuItem(
                        child: Row(
                          children: const [
                            Icon(Icons.check_circle_outline),
                            SizedBox(width: 10),
                            Text("100% construido"),
                          ],
                        ),
                        value: "100% construido",
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Fecha inicial",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                      if (date != null) {
                        final formattedDate = DateFormat.yMd().format(date);
                        quoteConsultPageController.dateStart.text =
                            formattedDate;
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: quoteConsultPageController.dateStart,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return Strings.pleaseFillOutTheField;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Fecha inicial",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelStyle: CustomStyle.textStyle,
                          filled: true,
                          fillColor: AppColors.lightColor,
                          hintStyle: CustomStyle.textStyle,
                          focusedBorder: CustomStyle.focusBorder,
                          enabledBorder: CustomStyle.focusErrorBorder,
                          focusedErrorBorder: CustomStyle.focusErrorBorder,
                          errorBorder: CustomStyle.focusErrorBorder,
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Fecha final",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      );
                      if (date != null) {
                        final formattedDate = DateFormat.yMd().format(date);
                        quoteConsultPageController.dateEnd.text = formattedDate;
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: quoteConsultPageController.dateEnd,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return Strings.pleaseFillOutTheField;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Fecha final",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          labelStyle: CustomStyle.textStyle,
                          filled: true,
                          fillColor: AppColors.lightColor,
                          hintStyle: CustomStyle.textStyle,
                          focusedBorder: CustomStyle.focusBorder,
                          enabledBorder: CustomStyle.focusErrorBorder,
                          focusedErrorBorder: CustomStyle.focusErrorBorder,
                          errorBorder: CustomStyle.focusErrorBorder,
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize * 3),
                  Center(
                    child: Text(
                      "Ejecutivos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.dp(1.8),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  Container(
                    height: responsive.hp(30),
                    child: ListView.builder(
                      itemCount:
                          quoteConsultPageController.executivesName.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              ' \u2022 ${quoteConsultPageController.executivesName[index]}'),
                        );
                      },
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
        child: Image.asset(
          'assets/icondef.png',
        ),
      ),
      onPressed: () {},
    );
  }
}

import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({Key? key}) : super(key: key);

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController = Get.put(UnitDetailPageController());

  @override
  void initState() {
    super.initState();
    unitDetailPageController.startController();
    unitDetailPageController.unitStatus.text = '******** Ramirez';
    unitDetailPageController.quoteHistory.text = '********';
    unitDetailPageController.bankHistory.text = '********';
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
              'Solicitud de credito',
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
                      SizedBox(width: responsive.wp(10)), // Add spacing between the images
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
                    "Unidad",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.unit,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Unidad",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Precio de venta",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.salePrice,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Precio de venta",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Nombre de cliente",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.unitStatus,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Nombre de cliente",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Telefono",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.quoteHistory,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Telefono",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Correo",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.bankHistory,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Correo",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Enganche",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.bankHistory,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enganche",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Plazo (Meses)",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.bankHistory,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Plazo (Meses)",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Taza ofertada",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: unitDetailPageController.bankHistory,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Taza ofertada",
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
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),

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
                          "Detalle del cliente",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RouterPaths.CLIENT_QUOTE_PAGE);
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
                          "Aplicar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RouterPaths.CLIENT_QUOTE_PAGE);
                    },
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
}

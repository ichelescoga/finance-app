import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDocumentsPage extends StatefulWidget {
  const ClientDocumentsPage({Key? key}) : super(key: key);

  @override
  State<ClientDocumentsPage> createState() => _ClientDocumentsPageState();
}

class _ClientDocumentsPageState extends State<ClientDocumentsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController = Get.put(UnitDetailPageController());

  @override
  void initState() {
    super.initState();
    unitDetailPageController.startController();
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
              'Adjuntar documentos',
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
                  const Text(
                    "Carta de ingresos",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text(
                            "Carta de ingresos",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.upload,
                            color: Colors.white,
                          )
                        ],)
                      ),
                    ),
                    onTap: () {
                      Get.back(closeOverlays: true);
                    },
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Recibo de servicios",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Recibo de servicios",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.largeTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5,),
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              )
                            ],)
                      ),
                    ),
                    onTap: () {
                      Get.back(closeOverlays: true);
                    },
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Referencias laborales",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Referencias laborales",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.largeTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5,),
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              )
                            ],)
                      ),
                    ),
                    onTap: () {
                      Get.back(closeOverlays: true);
                    },
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const Text(
                    "Referencias personales",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Referencias personales",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.largeTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5,),
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              )
                            ],)
                      ),
                    ),
                    onTap: () {
                      Get.back(closeOverlays: true);
                    },
                  ),
                  const SizedBox(height: Dimensions.heightSize*5),
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
                      Get.back(closeOverlays: true);
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

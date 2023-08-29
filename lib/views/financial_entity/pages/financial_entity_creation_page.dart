import 'dart:io';

import 'package:developer_company/views/financial_entity/controllers/financial_entity_creation_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FinancialEntityCreationPage extends StatefulWidget {
  const FinancialEntityCreationPage({Key? key}) : super(key: key);

  @override
  State<FinancialEntityCreationPage> createState() => _FinancialEntityCreationPageState();
}

class _FinancialEntityCreationPageState extends State<FinancialEntityCreationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FinancialEntityCreationPageController financialEntityCreationPageController = Get.put(FinancialEntityCreationPageController());

  int activeStep = 0;
  int _selectedOption = 0;
  double circleRadius = 20;
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0.25,
            backgroundColor: AppColors.BACKGROUND,
            title: Text(
              'Creacion de entidad financiera y ejecutivo',
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
                  SizedBox(height: responsive.hp(5)),
                  EasyStepper(
                    activeStep: activeStep,
                    lineLength: 70,
                    enableStepTapping: false,
                    lineType: LineType.normal,
                    defaultLineColor: Colors.white,
                    finishedLineColor: AppColors.mainColor,
                    activeStepTextColor: Colors.black87,
                    finishedStepTextColor: Colors.black87,
                    internalPadding: 0,
                    showLoadingAnimation: false,
                    stepRadius: 15,
                    showStepBorder: false,
                    lineDotRadius: 2,
                    steps: [
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: circleRadius,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: circleRadius,
                            backgroundColor:
                            activeStep >= 0 ? AppColors.mainColor : Colors.white,
                          ),
                        ),
                        title: 'Desarrolladora',
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: circleRadius,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: circleRadius,
                            backgroundColor:
                            activeStep >= 1 ? AppColors.mainColor : Colors.white,
                          ),
                        ),
                        title: 'Entidad financiera',
                        topTitle: true,
                      ),
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: circleRadius,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: circleRadius,
                            backgroundColor:
                            activeStep >= 2 ? AppColors.mainColor : Colors.white,
                          ),
                        ),
                        title: 'Ejecutivo',
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  activeStep == 0 ? developerWidget(context) : activeStep == 1 ? projectWidget(context) : dateWidget(context)

                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if(activeStep == 0){
            Get.back(closeOverlays: true);
          }else if(activeStep >= 1){
            activeStep -= 1;
            setState(() {});
          }
          return false;
        });
  }

  Widget developerWidget(BuildContext context){
    Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Desarrollador",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Desarrollador",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          GestureDetector(
            child: Container(
              height: 50.0,
              width: Get.width,
              decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logo",
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
                    ],
                  )),
            ),
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                financialEntityCreationPageController.developerLogo.value = pickedFile.path;
                financialEntityCreationPageController.update();
              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(height: Dimensions.heightSize),
          Obx(() => Center(
            child: financialEntityCreationPageController.developerLogo.value.isNotEmpty
                ? Image.file(File(financialEntityCreationPageController.developerLogo.value))
                : Text('Seleccione un logo por favor.'),
          )),
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Proyecto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Proyecto",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          GestureDetector(
            child: Container(
              height: 50.0,
              width: Get.width,
              decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logo",
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
                    ],
                  )),
            ),
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                financialEntityCreationPageController.projectLogo.value = pickedFile.path;
                financialEntityCreationPageController.update();
              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(height: Dimensions.heightSize),
          Obx(() => Center(
            child: financialEntityCreationPageController.projectLogo.value.isNotEmpty
                ? Image.file(File(financialEntityCreationPageController.projectLogo.value))
                : Text('Seleccione un logo por favor.'),
          )),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: Center(
                  child: Text(
                    "Siguiente".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () async {
                EasyLoading.show(status: 'Cargando...');
                await Future.delayed(const Duration(milliseconds: 100),
                        () async {
                      EasyLoading.dismiss();
                      activeStep = 1;
                      setState(() {});
                    });
              },
            ),
          ),
          const SizedBox(
            height: Dimensions.heightSize,
          ),
        ],
      ),
    );
  }
  Widget projectWidget(BuildContext context){
    Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Banco",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Banco",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Tipo de credito",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('Sobre saldo'),
                leading: Radio<int>(
                  value: 0,
                  groupValue: _selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Cuota nivelada'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: _selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Tasa de interes",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.interestRate,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Tasa de interes",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Meses maximo",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.maxMonths,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Meses maximo",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Pagos especiales",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.specialPayment,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Pagos especiales",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Enganche minimo",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.minimumDownPayment,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Enganche minimo",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Proyecto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.project,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Proyecto",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: Center(
                  child: Text(
                    "Siguiente".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () async {
                EasyLoading.show(status: 'Cargando...');
                await Future.delayed(const Duration(milliseconds: 100),
                        () async {
                      EasyLoading.dismiss();
                      activeStep = 2;
                      setState(() {});
                    });
              },
            ),
          ),
          const SizedBox(
            height: Dimensions.heightSize,
          ),
        ],
      ),
    );
  }
  Widget dateWidget(BuildContext context){
    Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ejecutivo de banco",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankExecutive,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Ejecutivo de banco",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Gerencia",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankManagement,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Gerencia",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Puesto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankPosition,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Puesto",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Telefono",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankCellPhone,
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Correo",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankEmail,
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "DPI",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankDPI,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "DPI",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Foto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: financialEntityCreationPageController.bankPhoto,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Foto",
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
                child: Center(
                  child: Text(
                    "Terminar".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () async {
                EasyLoading.show(status: 'Cargando...');
                await Future.delayed(const Duration(milliseconds: 1000),
                        () async {
                      EasyLoading.dismiss();
                      Get.back();
                      EasyLoading.showSuccess('Entidad financiera y ejecutivo creados exitosamente!');
                    });
              },
            ),
          ),
          const SizedBox(
            height: Dimensions.heightSize,
          ),
        ],
      ),
    );
  }
}

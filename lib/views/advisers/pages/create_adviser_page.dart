import 'dart:io';

import 'package:developer_company/views/advisers/controllers/create_adviser_page_controller.dart';
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

class CreateAdviserPage extends StatefulWidget {
  const CreateAdviserPage({Key? key}) : super(key: key);

  @override
  State<CreateAdviserPage> createState() => _CreateAdviserPageState();
}

class _CreateAdviserPageState extends State<CreateAdviserPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreateAdviserPageController createAdviserPageController = Get.put(CreateAdviserPageController());

  int activeStep = 0;
  double circleRadius = 20;
  @override
  void initState() {
    super.initState();
    createAdviserPageController.collaboratorRol.text = 'Asesor';
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
              'Crear asesor',
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
                        title: 'Desarrollador',
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
                        title: 'Colaborador',
                        topTitle: true,
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  activeStep == 0 ? developerWidget(context) : projectWidget(context)

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
            controller: createAdviserPageController.developerName,
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
                createAdviserPageController.developerLogo.value = pickedFile.path;
                createAdviserPageController.update();
              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(height: Dimensions.heightSize),
          Obx(() => Center(
            child: createAdviserPageController.developerLogo.value.isNotEmpty
                ? Image.file(File(createAdviserPageController.developerLogo.value))
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
            controller: createAdviserPageController.dpi,
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
                createAdviserPageController.projectLogo.value = pickedFile.path;
                createAdviserPageController.update();
              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(height: Dimensions.heightSize),
          Obx(() => Center(
            child: createAdviserPageController.projectLogo.value.isNotEmpty
                ? Image.file(File(createAdviserPageController.projectLogo.value))
                : Text('Seleccione un logo por favor.'),
          )),
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
          SizedBox(
            width: responsive.wp(100),
            height: responsive.hp(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Center(
                  child: createAdviserPageController.projectLogo.value.isNotEmpty
                      ? Image.file(File(createAdviserPageController.projectLogo.value), width: 130, height: 100,)
                      : Text('Seleccione un logo por favor.'),
                )),
                const SizedBox(
                  width: Dimensions.widthSize * 2,
                ),
                Obx(() => Center(
                  child: createAdviserPageController.developerLogo.value.isNotEmpty
                      ? Image.file(File(createAdviserPageController.developerLogo.value), width: 130, height: 100,)
                      : Text('Seleccione un logo por favor.'),
                )),
              ],
            ),
          ),
          const Text(
            "Nombre de colaborador",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createAdviserPageController.collaboratorName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Nombre de colaborador",
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
            controller: createAdviserPageController.collaboratorDPI,
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
            "NIT",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createAdviserPageController.collaboratorNIT,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "NIT",
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
            "Rol",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          DropdownButtonFormField<String>(
            style: CustomStyle.textStyle,
            value: createAdviserPageController.collaboratorRol.text,
            items: createAdviserPageController.rol.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              createAdviserPageController.collaboratorRol.text = newValue!;
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return Strings.pleaseFillOutTheField;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Departamento",
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
            controller: createAdviserPageController.collaboratorCellPhone,
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
            controller: createAdviserPageController.collaboratorEmail,
            keyboardType: TextInputType.name,
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
            "Foto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createAdviserPageController.collaboratorPhoto,
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
          const Text(
            "Comision",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createAdviserPageController.collaboratorCommission,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Comision",
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
            "Meta de ventas",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createAdviserPageController.collaboratorSalesGoal,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Meta de ventas",
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
                await Future.delayed(const Duration(milliseconds: 1000),
                        () async {
                      EasyLoading.dismiss();
                      Get.back();
                      EasyLoading.showSuccess('Asesor creado exitosamente!');
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

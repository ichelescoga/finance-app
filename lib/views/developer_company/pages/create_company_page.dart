import 'dart:io';
import 'package:developer_company/views/developer_company/controllers/create_company_page_controller.dart';
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
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreateCompanyPageController createCompanyPageController = Get.put(CreateCompanyPageController());

  int activeStep = 0;
  double circleRadius = 20;
  @override
  void initState() {
    super.initState();
    createCompanyPageController.dateState.text = 'En planos';
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
              'Crear empresa',
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
                        title: 'Proyecto',
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
                        title: 'Ventas',
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
            controller: createCompanyPageController.developerName,
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
          const Text(
            "NIT",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
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
            "Dirección",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Dirección",
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
            "Contacto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Contacto",
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
            "Teléfono de contacto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Teléfono de contacto",
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
            "Gerente de ventas",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Gerente de ventas",
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
            controller: createCompanyPageController.developerName,
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
                createCompanyPageController.filePath.value = pickedFile.path;
                createCompanyPageController.update();
              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(height: Dimensions.heightSize),
          Obx(() => Center(
            child: createCompanyPageController.filePath.value.isNotEmpty
                ? Image.file(File(createCompanyPageController.filePath.value))
                : Text('Seleccione un logo por favor.'),
          )),
          const SizedBox(height: Dimensions.heightSize),
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
          Obx(() => Center(
            child: createCompanyPageController.filePath.value.isNotEmpty
                ? Image.file(File(createCompanyPageController.filePath.value))
                : Text('Seleccione un logo por favor.'),
          )),
          const SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          const Text(
            "Nombre proyecto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Nombre proyecto",
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
            "Departamento",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          DropdownButtonFormField<String>(
            style: CustomStyle.textStyle,
            value: createCompanyPageController.departmentSelected,
            items: createCompanyPageController.departments.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              createCompanyPageController.departmentSelected = newValue!;
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
            "Municipio",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          DropdownButtonFormField<String>(
            style: CustomStyle.textStyle,
            value: createCompanyPageController.selectedMunicipality,
            items: createCompanyPageController.municipalities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              createCompanyPageController.selectedMunicipality = newValue!;
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return Strings.pleaseFillOutTheField;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Municipio",
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
            "Direccion",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.developerName,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: "Direccion",
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
            "Tipo de proyecto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          DropdownButtonFormField<String>(
            style: CustomStyle.textStyle,
            value: createCompanyPageController.selectedProperty,
            items: createCompanyPageController.propertyTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              createCompanyPageController.selectedProperty = newValue!;
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return Strings.pleaseFillOutTheField;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Tipo de proyecto",
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
            "Cantidad de unidades en venta",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.projectUnityOnSale,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            onChanged: (value){
              createCompanyPageController.dateCostTotal.text = (num.parse(createCompanyPageController.dateCostUnity.text) * num.parse(createCompanyPageController.projectUnityOnSale.text)).toString();
            },
            decoration: InputDecoration(
              hintText: "Cantidad de unidades en venta",
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
                  borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logo proyecto",
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
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                createCompanyPageController.projectFilePath.value = pickedFile.path;
                createCompanyPageController.update();
              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(height: Dimensions.heightSize),
          Obx(() => Center(
            child: createCompanyPageController.projectFilePath.value.isNotEmpty
                ? Image.file(File(createCompanyPageController.projectFilePath.value))
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
          Obx(() => Center(
            child: createCompanyPageController.filePath.value.isNotEmpty
                ? Image.file(File(createCompanyPageController.filePath.value))
                : Text('Seleccione un logo por favor.'),
          )),
          const SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          Obx(() => Center(
            child: createCompanyPageController.projectFilePath.value.isNotEmpty
                ? Image.file(File(createCompanyPageController.projectFilePath.value))
                : Text('Seleccione un logo por favor.'),
          )),
          const SizedBox(
            height: Dimensions.heightSize * 2,
          ),
          const Text(
            "Fecha de inicio de venta",
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
                createCompanyPageController.dateStart.text = formattedDate;
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: createCompanyPageController.dateStart,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Fecha de inicio de venta",
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Fecha final de venta",
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
                createCompanyPageController.dateEnd.text = formattedDate;
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: createCompanyPageController.dateEnd,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Fecha final de de venta",
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          const Text(
            "Costo promedio por unidad",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.dateCostUnity,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            onChanged: (value){
              createCompanyPageController.dateCostTotal.text = (num.parse(createCompanyPageController.dateCostUnity.text) * num.parse(createCompanyPageController.projectUnityOnSale.text)).toString();
            },
            decoration: InputDecoration(
              hintText: "Costo promedio por unidad",
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
            "Costo total de venta",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: createCompanyPageController.dateCostTotal,
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            enabled: false,
            decoration: InputDecoration(
              hintText: "Costo total de venta",
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
            "Estado del proyecto",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          DropdownButtonFormField<String>(
            value: createCompanyPageController.dateState.text,
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
                createCompanyPageController.dateState.text = newValue!;
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
          const SizedBox(
            height: Dimensions.heightSize,
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
                        "Mapa",
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
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                createCompanyPageController.mapFilePath.value = pickedFile.path;
                createCompanyPageController.update();

              } else {
                print('No image selected.');
              }
            },
          ),
          const SizedBox(
            height: Dimensions.heightSize,
          ),
          Obx(() => Center(
            child: createCompanyPageController.mapFilePath.value.isNotEmpty
                ? Image.file(File(createCompanyPageController.mapFilePath.value))
                : Text('Seleccione un mapa por favor.'),
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
                      EasyLoading.showSuccess('Empresa creada exitosamente!');
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

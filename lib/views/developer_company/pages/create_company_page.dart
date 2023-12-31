// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:developer_company/shared/validations/nit_validation.dart';
import 'package:developer_company/views/developer_company/controllers/create_company_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_dropdown_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKeyDeveloper = GlobalKey<FormState>();
  final _formKeyProject = GlobalKey<FormState>();
  final _formKeySells = GlobalKey<FormState>();
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());

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
            title: const Text(
              'Crear empresa',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: responsive.wp(5), right: responsive.wp(5)),
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
                    lineThickness: 2,
                    steps: [
                      EasyStep(
                        customStep: CircleAvatar(
                          radius: circleRadius,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: circleRadius,
                            backgroundColor: activeStep >= 0
                                ? AppColors.mainColor
                                : Colors.white,
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
                            backgroundColor: activeStep >= 1
                                ? AppColors.mainColor
                                : Colors.white,
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
                            backgroundColor: activeStep >= 2
                                ? AppColors.mainColor
                                : Colors.white,
                          ),
                        ),
                        title: 'Ventas',
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  activeStep == 0
                      ? developerWidget(context)
                      : activeStep == 1
                          ? projectWidget(context)
                          : dateWidget(context)
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (activeStep == 0) {
            Get.back(closeOverlays: true);
          } else if (activeStep >= 1) {
            activeStep -= 1;
            setState(() {});
          }
          return false;
        });
  }

  //? STEPS

  Widget developerWidget(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
      child: Form(
        key: _formKeyDeveloper,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputWidget(
              controller: createCompanyPageController.developerName,
              label: "Desarrollador",
              hintText: "Desarrollador",
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.name,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
            ),
            CustomInputWidget(
                controller: createCompanyPageController.developerNit,
                label: "NIT",
                hintText: "NIT",
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.text,
                validator: (String? value) => nitValidation(value)),
            CustomInputWidget(
              controller: createCompanyPageController.developerAddress,
              label: "Dirección",
              hintText: "Dirección",
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerContact,
              label: "Contacto",
              hintText: "Contacto",
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerContactPhone,
              label: "Teléfono de contacto",
              hintText: "Teléfono de contacto",
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerSalesManager,
              label: "Gerente de ventas",
              hintText: "Gerente de ventas",
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerPhone,
              label: "Teléfono",
              hintText: "Teléfono",
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return Strings.pleaseFillOutTheField;
                } else {
                  return null;
                }
              },
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
                      "Logo",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.upload,
                      color: Colors.white,
                    )
                  ],
                )),
              ),
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
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
                      ? Image.file(
                          File(createCompanyPageController.filePath.value))
                      : const Text('Seleccione un logo por favor.'),
                )),
            const SizedBox(height: Dimensions.heightSize),
            CustomButtonWidget(
                text: "Siguiente".toUpperCase(),
                onTap: () async {
                  if (_formKeyDeveloper.currentState!.validate()) {
                    print("😉 PASS VALIDATIONS");

                    EasyLoading.show(status: 'Cargando...');
                    await Future.delayed(const Duration(milliseconds: 100),
                        () async {
                      EasyLoading.dismiss();
                      activeStep = 1;
                      setState(() {});
                    });
                  } else {
                    EasyLoading.showError('Por favor valide campos.');
                  }
                }),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget projectWidget(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
      child: Form(
        key: _formKeyProject,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Center(
                  child: createCompanyPageController.filePath.value.isNotEmpty
                      ? Image.file(
                          File(createCompanyPageController.filePath.value))
                      : const Text('Seleccione un logo por favor.'),
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
            CustomDropdownWidget(
                labelText: "Departamento",
                hintText: "Departamento",
                selectedValue: createCompanyPageController.departmentSelected,
                items: createCompanyPageController.departments
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onValueChanged: (String? newValue) {
                  createCompanyPageController.departmentSelected = newValue!;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.person_outline)),
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
              items: createCompanyPageController.municipalities
                  .map<DropdownMenuItem<String>>((String value) {
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
              "Tipo de proyecto",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: Dimensions.heightSize * 0.5,
            ),
            DropdownButtonFormField<String>(
              style: CustomStyle.textStyle,
              value: createCompanyPageController.selectedProperty,
              items: createCompanyPageController.propertyTypes
                  .map<DropdownMenuItem<String>>((String value) {
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
              onChanged: (value) {
                createCompanyPageController.dateCostTotal.text =
                    (num.parse(createCompanyPageController.dateCostUnity.text) *
                            num.parse(createCompanyPageController
                                .projectUnityOnSale.text))
                        .toString();
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
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.upload,
                      color: Colors.white,
                    )
                  ],
                )),
              ),
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  createCompanyPageController.projectFilePath.value =
                      pickedFile.path;
                  createCompanyPageController.update();
                } else {
                  //! print('No image selected.');
                }
              },
            ),
            const SizedBox(height: Dimensions.heightSize),
            Obx(() => Center(
                  child: createCompanyPageController
                          .projectFilePath.value.isNotEmpty
                      ? Image.file(File(
                          createCompanyPageController.projectFilePath.value))
                      : const Text('Seleccione un logo por favor.'),
                )),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    text: "Atrás".toUpperCase(),
                    onTap: () async {
                      EasyLoading.show(status: 'Cargando...');
                      await Future.delayed(const Duration(milliseconds: 100),
                          () async {
                        EasyLoading.dismiss();
                        setState(() {
                          activeStep = 0;
                        });
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonWidget(
                    text: "Siguiente".toUpperCase(),
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
              ],
            ),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget dateWidget(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Padding(
      padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
      child: Form(
        key: _formKeySells,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Center(
                  child: createCompanyPageController.filePath.value.isNotEmpty
                      ? Image.file(
                          File(createCompanyPageController.filePath.value))
                      : const Text('Seleccione un logo por favor.'),
                )),
            const SizedBox(
              height: Dimensions.heightSize * 2,
            ),
            Obx(() => Center(
                  child: createCompanyPageController
                          .projectFilePath.value.isNotEmpty
                      ? Image.file(File(
                          createCompanyPageController.projectFilePath.value))
                      : const Text('Seleccione un logo por favor.'),
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
              onChanged: (value) {
                createCompanyPageController.dateCostTotal.text =
                    (num.parse(createCompanyPageController.dateCostUnity.text) *
                            num.parse(createCompanyPageController
                                .projectUnityOnSale.text))
                        .toString();
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
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.design_services),
                      SizedBox(width: 10),
                      Text("En planos"),
                    ],
                  ),
                  value: "En planos",
                ),
                DropdownMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.construction),
                      SizedBox(width: 10),
                      Text("En construcción"),
                    ],
                  ),
                  value: "En construcción",
                ),
                DropdownMenuItem(
                  child: Row(
                    children: [
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
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.upload,
                      color: Colors.white,
                    )
                  ],
                )),
              ),
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  createCompanyPageController.mapFilePath.value =
                      pickedFile.path;
                  createCompanyPageController.update();
                } else {
                  //! print('No image selected.');
                }
              },
            ),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
            Obx(() => Center(
                  child: createCompanyPageController
                          .mapFilePath.value.isNotEmpty
                      ? Image.file(
                          File(createCompanyPageController.mapFilePath.value))
                      : const Text('Seleccione un mapa por favor.'),
                )),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    text: "Atrás".toUpperCase(),
                    onTap: () async {
                      EasyLoading.show(status: 'Cargando...');
                      await Future.delayed(const Duration(milliseconds: 100),
                          () async {
                        EasyLoading.dismiss();
                        setState(() {
                          activeStep = 1;
                        });
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonWidget(
                    text: "Terminar".toUpperCase(),
                    onTap: () async {
                      createCompanyPageController.developerName.value.text;
                      createCompanyPageController.developerNit.value.text;
                      createCompanyPageController.developerAddress.value.text;
                      createCompanyPageController.developerContact.value.text;
                      createCompanyPageController
                          .developerContactPhone.value.text;
                      createCompanyPageController
                          .developerSalesManager.value.text;
                      createCompanyPageController.developerPhone.value.text;
                      createCompanyPageController.projectName.value.text;
                      createCompanyPageController.projectDepartment.value.text;
                      createCompanyPageController
                          .projectMunicipality.value.text;
                      createCompanyPageController.projectAddress.value.text;
                      createCompanyPageController.projectType.value.text;
                      createCompanyPageController.projectUnityOnSale.value.text;
                      createCompanyPageController.dateStart.value.text;
                      createCompanyPageController.dateEnd.value.text;
                      createCompanyPageController.dateAverage.value.text;
                      createCompanyPageController.dateCostUnity.value.text;
                      createCompanyPageController.dateCostTotal.value.text;
                      createCompanyPageController.dateState.value.text;
                      createCompanyPageController.dateMap.value.text;
                      createCompanyPageController.filePath.value;
                      createCompanyPageController.projectFilePath.value;
                      createCompanyPageController.mapFilePath.value;
                      // EasyLoading.show(status: 'Cargando...');
                      // await Future.delayed(const Duration(milliseconds: 1000),
                      //     () async {
                      //   EasyLoading.dismiss();
                      //   Get.back();
                      //   EasyLoading.showSuccess('Empresa creada exitosamente!');
                      // });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/nit_validation.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/views/advisers/controllers/create_adviser_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_dropdown_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
// import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreateAdviserPage extends StatefulWidget {
  const CreateAdviserPage({Key? key}) : super(key: key);

  @override
  State<CreateAdviserPage> createState() => _CreateAdviserPageState();
}

class _CreateAdviserPageState extends State<CreateAdviserPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKeyDeveloper = GlobalKey<FormState>();
  final _formKeyCollaborator = GlobalKey<FormState>();
  CreateAdviserPageController createAdviserPageController =
      Get.put(CreateAdviserPageController());

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
            title: const Text(
              'Crear asesor',
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
                        title: 'Desarrollador',
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
                        title: 'Colaborador',
                        topTitle: true,
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  activeStep == 0
                      ? developerWidget(context)
                      : projectWidget(context)
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
                controller: createAdviserPageController.developerName,
                label: "Desarrollador",
                hintText: "Desarrollador",
                validator: (value) => notEmptyFieldValidator(value),
                prefixIcon: Icons.person_outline),
            // LogoUploadWidget(
            //   text: "Logo",
            //   validator: (value) {
            //     if (value == null) {
            //       return "Seleccione un logo para desarrollador";
            //     }
            //     return null;
            //   },
            // ),
            CustomInputWidget(
                controller: createAdviserPageController.dpi,
                label: "Proyecto",
                hintText: "Proyecto",
                validator: (value) => notEmptyFieldValidator(value),
                prefixIcon: Icons.person_outline),
            // LogoUploadWidget(
            //   text: "Logo",
            //   validator: (value) {
            //     if (value == null) {
            //       return "Seleccione un logo para Proyecto";
            //     }
            //     return null;
            //   },
            // ),
            CustomButtonWidget(
                text: "Siguiente".toUpperCase(),
                onTap: () async {
                  if (_formKeyDeveloper.currentState!.validate()) {
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
        key: _formKeyCollaborator,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: responsive.wp(100),
              height: responsive.hp(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Center(
                        child: createAdviserPageController
                                .projectLogo.value.isNotEmpty
                            ? Image.file(
                                File(createAdviserPageController
                                    .projectLogo.value),
                                width: 130,
                                height: 100,
                              )
                            : const Text('Seleccione un logo por favor.'),
                      )),
                  const SizedBox(
                    width: Dimensions.widthSize * 2,
                  ),
                  Obx(() => Center(
                        child: createAdviserPageController
                                .developerLogo.value.isNotEmpty
                            ? Image.file(
                                File(createAdviserPageController
                                    .developerLogo.value),
                                width: 130,
                                height: 100,
                              )
                            : const Text('Seleccione un logo por favor.'),
                      )),
                ],
              ),
            ),
            CustomInputWidget(
                controller: createAdviserPageController.collaboratorName,
                label: "Nombre de colaborador",
                hintText: "Nombre de colaborador",
                validator: (value) => notEmptyFieldValidator(value),
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                controller: createAdviserPageController.collaboratorNIT,
                label: "NIT",
                hintText: "NIT",
                prefixIcon: Icons.person_outline,
                validator: (value) => nitValidation(value)),
            CustomDropdownWidget(
                labelText: "Rol",
                hintText: "Asesor",
                selectedValue: createAdviserPageController.collaboratorRol.text,
                items: createAdviserPageController.rol
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) => notEmptyFieldValidator(value),
                prefixIcon: const Icon(Icons.person_outline),
                onValueChanged: (String? newValue) {
                  createAdviserPageController.collaboratorRol.text = newValue!;
                }),
            CustomInputWidget(
                controller: createAdviserPageController.collaboratorCellPhone,
                label: "Teléfono",
                hintText: "Teléfono",
                prefixIcon: Icons.person_outline,
                validator: (value) => notEmptyFieldValidator(value)),
            CustomInputWidget(
                controller: createAdviserPageController.collaboratorEmail,
                label: "Correo",
                hintText: "Correo",
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => emailValidator(value)),
            CustomInputWidget(
              controller: createAdviserPageController.collaboratorPhoto,
              label: "Foto",
              hintText: "Foto",
              prefixIcon: Icons.person_outline,
              validator: (value) => notEmptyFieldValidator(value),
            ),
            CustomInputWidget(
              controller: createAdviserPageController.collaboratorCommission,
              label: "Comisión",
              hintText: "Comisión",
              prefixIcon: Icons.person_outline,
              validator: (value) => notEmptyFieldValidator(value),
            ),
            CustomInputWidget(
              controller: createAdviserPageController.collaboratorSalesGoal,
              label: "Meta de ventas",
              hintText: "Meta de ventas",
              prefixIcon: Icons.person_outline,
              validator: (value) => notEmptyFieldValidator(value),
            ),
            Row(
              children: [
                Expanded(
                    child: CustomButtonWidget(
                  text: "Atrás".toUpperCase(),
                  onTap: () async {
                    EasyLoading.show(status: 'Cargando...');
                    await Future.delayed(const Duration(milliseconds: 1000),
                        () async {
                      EasyLoading.dismiss();
                    });
                    setState(() {
                      activeStep = 0;
                    });
                  },
                )),
                Expanded(
                    child: CustomButtonWidget(
                  text: "Siguiente".toUpperCase(),
                  onTap: () async {
                    if (_formKeyCollaborator.currentState!.validate()) {
                      EasyLoading.show(status: 'Cargando...');
                      await Future.delayed(const Duration(milliseconds: 1000),
                          () async {
                        EasyLoading.dismiss();
                        Get.back();
                        EasyLoading.showSuccess('Asesor creado exitosamente!');
                      });
                    } else {
                      EasyLoading.showError('Por favor valide campos.');
                    }
                  },
                ))
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
}

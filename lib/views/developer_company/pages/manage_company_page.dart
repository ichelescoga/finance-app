// ignore_for_file: deprecated_member_use
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/views/developer_company/controllers/create_company_page_controller.dart';
// import 'package:developer_company/shared/resources/colors.dart';
// import 'package:developer_company/shared/resources/dimensions.dart';
// import 'package:developer_company/shared/utils/responsive.dart';
// import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final _formKeyDeveloper = GlobalKey<FormState>();
  // final _formKeyProject = GlobalKey<FormState>();
  // final _formKeySells = GlobalKey<FormState>();
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());

  int activeStep = 0;
  double circleRadius = 20;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive responsive = Responsive.of(context);

    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Gestión empresas",
        ),
        child: Column(
          children: [
            CustomInputWidget(
              controller: createCompanyPageController.developerCompanyName,
              label: "Nombre empresa",
              hintText: "Nombre Empresa",
              prefixIcon: Icons.business,
            ),
            CustomInputWidget(
              controller:
                  createCompanyPageController.developerCompanyDescription,
              label: "Descripción",
              hintText: "Descripción de la empresa",
              prefixIcon: Icons.description,
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerCompanyDeveloper,
              label: "Desarrollador",
              hintText: "Nombre del desarrollador",
              prefixIcon: Icons.person,
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerCompanyNit,
              label: "NIT",
              hintText: "Número de Identificación Tributaria",
              prefixIcon: Icons.confirmation_number,
            ),
            CustomInputWidget(
              controller: createCompanyPageController.developerCompanyAddress,
              label: "Dirección",
              hintText: "Dirección de la empresa",
              prefixIcon: Icons.location_on,
            ),
            CustomInputWidget(
              controller:
                  createCompanyPageController.developerCompanyContactPhone,
              label: "Teléfono de Contacto",
              hintText: "Número de teléfono de contacto",
              prefixIcon: Icons.phone,
            ),
            CustomInputWidget(
              controller:
                  createCompanyPageController.developerCompanyContactName,
              label: "Nombre de Contacto",
              hintText: "Nombre de la persona de contacto",
              prefixIcon: Icons.person_pin,
            ),
            CustomInputWidget(
              controller:
                  createCompanyPageController.developerCompanySellManager,
              label: "Gerente de Ventas",
              hintText: "Nombre del gerente de ventas",
              prefixIcon: Icons.supervised_user_circle,
            ),
            CustomInputWidget(
              controller:
                  createCompanyPageController.developerCompanySellManagerPhone,
              label: "Teléfono del Gerente de Ventas",
              hintText: "Número de teléfono del gerente de ventas",
              prefixIcon: Icons.phone_android,
            ),
            LogoUploadWidget(
              text: "Logotipo",
              validator: (value) {
                if (value == null) {
                  return "Seleccione un logo para Proyecto";
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                      text: "Atrás",
                      onTap: () => Navigator.pop(context, false)),
                ),
                Expanded(
                  child: CustomButtonWidget(
                      color: AppColors.blueColor,
                      text: "Guardar",
                      onTap: () {}),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
          ],
        ));
  }
}

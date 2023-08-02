import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAdviserPageController extends BaseController{
  TextEditingController developerName = TextEditingController();
  TextEditingController developerNit = TextEditingController();
  TextEditingController legalPerson = TextEditingController();
  TextEditingController dpi = TextEditingController();
  TextEditingController salesManager = TextEditingController();
  TextEditingController cellPhone = TextEditingController();

  TextEditingController collaboratorName = TextEditingController();
  TextEditingController collaboratorDPI = TextEditingController();
  TextEditingController collaboratorNIT = TextEditingController();
  TextEditingController collaboratorRol = TextEditingController();
  TextEditingController collaboratorCellPhone = TextEditingController();
  TextEditingController collaboratorEmail = TextEditingController();
  TextEditingController collaboratorPhoto = TextEditingController();
  TextEditingController collaboratorCommission = TextEditingController();
  TextEditingController collaboratorSalesGoal = TextEditingController();

  RxString developerLogo = ''.obs;
  RxString projectLogo = ''.obs;

  final List<String> rol = [
  'Administrador de Proyecto',
  'Desarrollador',
  'Proyecto',
  'Gerente de Finanzas',
  'Gerente de Operaciones',
  'Gerente de Ventas',
  'Supervisor de Ventas',
  'Asesor'
  ];

}
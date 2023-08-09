import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCompanyPageController extends BaseController{
  TextEditingController developerName = TextEditingController();
  TextEditingController developerNit = TextEditingController();
  TextEditingController developerAddress = TextEditingController();
  TextEditingController developerContact = TextEditingController();
  TextEditingController developerContactPhone = TextEditingController();
  TextEditingController developerSalesManager = TextEditingController();
  TextEditingController developerPhone = TextEditingController();

  TextEditingController projectName = TextEditingController();
  TextEditingController projectDepartment = TextEditingController();
  TextEditingController projectMunicipality = TextEditingController();
  TextEditingController projectAddress = TextEditingController();
  TextEditingController projectType = TextEditingController();
  TextEditingController projectUnityOnSale = TextEditingController();

  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController dateAverage = TextEditingController();
  TextEditingController dateCostUnity = TextEditingController();
  TextEditingController dateCostTotal = TextEditingController();
  TextEditingController dateState = TextEditingController();
  TextEditingController dateMap = TextEditingController();

  RxString filePath = ''.obs;
  RxString projectFilePath = ''.obs;
  RxString mapFilePath = ''.obs;

  final List<String> departments = ['Alta Verapaz', 'Baja Verapaz', 'Chimaltenango', 'Chiquimula', 'Petén', 'El Progreso', 'Quiché', 'Escuintla', 'Guatemala', 'Huehuetenango', 'Izabal', 'Jalapa', 'Jutiapa', 'Quetzaltenango', 'Retalhuleu', 'Sacatepéquez', 'San Marcos', 'Santa Rosa', 'Sololá', 'Suchitepéquez', 'Totonicapán', 'Zacapa'];
  String departmentSelected = 'Guatemala';
  final List<String> municipalities = [
    'Ciudad de Guatemala',
    'Santa Catarina Pinula',
    'San José Pinula',
    'San José del Golfo',
    'Palencia',
    'Chinautla',
    'San Pedro Ayampuc',
    'Mixco',
    'San Pedro Sacatepéquez',
    'San Juan Sacatepéquez',
    'San Raymundo',
    'Chuarrancho',
    'Fraijanes',
    'Amatitlán',
    'Villa Nueva',
    'Villa Canales',
    'Petapa',
  ];
  String selectedMunicipality = 'Ciudad de Guatemala';
  List<String> propertyTypes = [
    'Apartamentos',
    'Casas Condominio',
    'Casas',
    'Terrenos',
    'Lotes',
    'Finca',
  ];
  String selectedProperty = 'Apartamentos';

}
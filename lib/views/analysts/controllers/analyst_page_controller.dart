import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
// analyst_list_credits
class AnalystPageController extends BaseController{
  TextEditingController developers = TextEditingController();
  TextEditingController collaborators = TextEditingController();
  TextEditingController developer = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();

  TextEditingController unitType = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController unitStatus = TextEditingController();
  TextEditingController quoteHistory = TextEditingController();
  TextEditingController bankHistory = TextEditingController();

  final List<String> unitTypeList = [
    "Cotización",
    "En proceso",
    "Vendidas",
  ];

  bool unitCheck = false;
  bool clientCheck = false;
  bool executiveCheck = false;

  void startController(){
    developers.text = 'Alejandro Ramirez';
    collaborators.text = 'Josue Perez';
    developer.text = '';
    status.text = 'En proceso';
    dateStart.text = '12/05/2023';
    dateEnd.text = '12/05/2024';

    unitType.text = 'Vendidas';
  }

  final List<String> executivesName = [
    'Jose Pueblo',
    'Doroteo Alvarez',
    'Maria de lo Angeles',
  ];
}
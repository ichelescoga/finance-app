import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitDetailPageController extends BaseController{
  TextEditingController unitType = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController unitStatus = TextEditingController();
  TextEditingController quoteHistory = TextEditingController();
  TextEditingController bankHistory = TextEditingController();

  bool unitCheck = false;
  bool clientCheck = false;
  bool executiveCheck = false;

  RxString frontDpi = ''.obs;
  RxString reverseDpi = ''.obs;

  void startController(){
    unit.text = "Unidad de prueba";
    salePrice.text = "Q 450,000.00";
    unitStatus.text = "En proceso";
  }
}
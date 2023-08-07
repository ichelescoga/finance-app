import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialEntityCreationPageController extends BaseController{
  TextEditingController developerName = TextEditingController();
  TextEditingController developerNit = TextEditingController();
  TextEditingController developerLegalRepresentative = TextEditingController();
  TextEditingController developerDPI = TextEditingController();
  TextEditingController developerSalesManager = TextEditingController();
  TextEditingController developerPhone = TextEditingController();

  TextEditingController bankName = TextEditingController();
  TextEditingController creditType = TextEditingController();
  TextEditingController interestRate = TextEditingController();
  TextEditingController maxMonths = TextEditingController();
  TextEditingController specialPayment = TextEditingController();
  TextEditingController minimumDownPayment = TextEditingController();
  TextEditingController project = TextEditingController();

  TextEditingController bankExecutive = TextEditingController();
  TextEditingController bankManagement = TextEditingController();
  TextEditingController bankPosition = TextEditingController();
  TextEditingController bankCellPhone = TextEditingController();
  TextEditingController bankEmail = TextEditingController();
  TextEditingController bankDPI = TextEditingController();
  TextEditingController bankPhoto = TextEditingController();

  RxString developerLogo = ''.obs;
  RxString projectLogo = ''.obs;

}
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCompanyPageController extends BaseController {
  TextEditingController developerCompanyName = TextEditingController();
  TextEditingController developerCompanyDescription = TextEditingController();
  TextEditingController developerCompanyDeveloper = TextEditingController();
  TextEditingController developerCompanyNit = TextEditingController();
  TextEditingController developerCompanyAddress = TextEditingController();
  TextEditingController developerCompanyContactPhone = TextEditingController();
  TextEditingController developerCompanyContactName = TextEditingController();
  TextEditingController developerCompanySellManager = TextEditingController();
  TextEditingController developerCompanySellManagerPhone =
      TextEditingController();

  RxString filePath = ''.obs;
  RxString projectFilePath = ''.obs;
  RxString mapFilePath = ''.obs;
}

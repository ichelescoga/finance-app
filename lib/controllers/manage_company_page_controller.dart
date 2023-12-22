import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';

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

  ImageToUpload developerCompanyLogo = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

  cleanDeveloperCompanyForm() {
    developerCompanyName.clear();
    developerCompanyDescription.clear();
    developerCompanyDeveloper.clear();
    developerCompanyNit.clear();
    developerCompanyAddress.clear();
    developerCompanyContactPhone.clear();
    developerCompanyContactName.clear();
    developerCompanySellManager.clear();
    developerCompanySellManagerPhone.clear();
    
    developerCompanyLogo.reset();
  }

}

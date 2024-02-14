import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends BaseController {
  TextEditingController emailController = TextEditingController(text: "ejecutivoprueba@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "FinanceApp");
  RxBool passwordVisibility = false.obs;
  RxBool confirmPasswordVisibility = false.obs;

  cleanController() {
    emailController.clear();
    passwordController.clear();
  }

  bool isValidEmail(String email) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }
}

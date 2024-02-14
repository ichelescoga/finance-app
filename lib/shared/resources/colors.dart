// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const Color PRINCIPAL_COLOR = Color(0xff8B4513);
  static const Color DEGRADED_BACKGROUND = Color(0xffD3D3D3);
  static const Color PRINCIPAL_BUTTON = Color(0xffFFFFE0);
  static const Color SECONDARY_BUTTON = Color(0xffCD853F);
  static const Color BACKGROUND_INPUTS = Color(0xfff1f1df);
  static const Color BACKGROUND = Color(0xfff5f6fa);

  static const Color softMainColor = Color(0xff3e5ac6);
  static const Color mainColor = Color(0xff695bc2); // Color(0xff5673d9);
  static const Color secondaryMainColor =
      Color(0xFF8175C4); // Color(0xff5673d9);
  static const Color lightColor = Color(0xffedf0fc);
  static const Color lightSecondaryColor = Color(0xffd9dbe7);

  static const Color yellowLightColor = Color(0xFFFDF5E6);
  static const Color redDarkColor = Color(0xFF2B0100);
  static const Color redColor = Color(0xFFD90404);
  static const Color greyColor = Color(0xFF707070);
  static const Color greenColor = Color(0xFF03A60F);
  static const Color greenLightColor = Color(0xFFE5F6E7);
  static const Color blueColor = Color(0xFF307AFF);
  static const Color alternativeBlack = Color(0xFF444B54);
  static const Color greyColor90 = Color.fromARGB(255, 235, 235, 235);
  static const Color officialWhite = Color(0xFFFFFFFF);

  dataRowColors(index) {
    return index % 2 == 0
        ? MaterialStateProperty.all<Color>(AppColors.lightColor)
        : MaterialStateProperty.all<Color>(AppColors.lightSecondaryColor);
  }
}

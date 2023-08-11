import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.mainColor,
                  AppColors.mainColor,
                  AppColors.mainColor,
                  AppColors.softMainColor,
                ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/appstore165.png',
              fit: BoxFit.cover,
              height: 95,
              width: 95,
            ),
            const SizedBox(height: Dimensions.heightSize),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginSize * 2,
                  right: Dimensions.marginSize * 2),
              child: Text(
                Strings.appName,
                style: const TextStyle(
                    fontSize: Dimensions.largeTextSize * 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: Dimensions.heightSize * 6,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginSize * 2,
                  right: Dimensions.marginSize * 2),
              child: GestureDetector(
                child: Container(
                  height: Dimensions.buttonHeight,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors.lightColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius)),
                  child: Center(
                    child: Text(
                      Strings.signIn.toUpperCase(),
                      style: const TextStyle(
                          fontSize: Dimensions.extraLargeTextSize,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(RouterPaths.LOGIN_PAGE);
                },
              ),
            ),
            const SizedBox(
              height: Dimensions.heightSize,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginSize * 2,
                  right: Dimensions.marginSize * 2),
              child: GestureDetector(
                child: Container(
                  height: Dimensions.buttonHeight,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors.lightColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius)),
                  child: Center(
                    child: Text(
                      Strings.signUp.toUpperCase(),
                      style:const TextStyle(
                          fontSize: Dimensions.extraLargeTextSize,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(RouterPaths.REGISTER_PAGE);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

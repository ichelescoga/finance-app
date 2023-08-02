import 'package:developer_company/home/controllers/register_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routhes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterPageController registerPageController = Get.put(RegisterPageController());

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  size: 28, color: Colors.black54),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0.25,
            backgroundColor: const Color(0xfff5f6fa),
            title: Text(
              Strings.signUp.toUpperCase(),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsive.hp(2)),
                  const Text(
                    "Nombre completo",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: registerPageController.fullNameController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Nombre completo",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: AppColors.lightColor,
                      hintStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  const Text(
                    "Correo electrónico",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: registerPageController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else if (!registerPageController.isValidEmail(value)) {
                        return "Correo electrónico inválido";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Correo electrónico",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      labelStyle: CustomStyle.textStyle,
                      filled: true,
                      fillColor: AppColors.lightColor,
                      hintStyle: CustomStyle.textStyle,
                      focusedBorder: CustomStyle.focusBorder,
                      enabledBorder: CustomStyle.focusErrorBorder,
                      focusedErrorBorder: CustomStyle.focusErrorBorder,
                      errorBorder: CustomStyle.focusErrorBorder,
                      prefixIcon: const Icon(Icons.mail_outline),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  const Text(
                    "Contraseña",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  Obx(
                        () => TextFormField(
                      style: CustomStyle.textStyle,
                      controller: registerPageController.passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.typePassword,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        filled: true,
                        fillColor: AppColors.lightColor,
                        hintStyle: CustomStyle.textStyle,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            registerPageController.passwordVisibility.value = !registerPageController.passwordVisibility.value;
                          },
                          icon: registerPageController.passwordVisibility.value
                              ? const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                              : const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      obscureText: registerPageController.passwordVisibility.value,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  const Text(
                    "Confirmar contraseña",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  Obx(
                        () => TextFormField(
                      style: CustomStyle.textStyle,
                      controller: registerPageController.confirmPasswordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.typeRePassword,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        filled: true,
                        fillColor: AppColors.lightColor,
                        hintStyle: CustomStyle.textStyle,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            registerPageController.confirmPasswordVisibility.value =
                            !registerPageController.confirmPasswordVisibility.value;
                          },
                          icon: registerPageController.confirmPasswordVisibility.value
                              ? const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                              : const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      obscureText: registerPageController.confirmPasswordVisibility.value,
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.marginSize, right: Dimensions.marginSize),
                    child: GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(Dimensions.radius))),
                        child: Center(
                          child: Text(
                            Strings.createAccount.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () async {
                        String nm = registerPageController.fullNameController.text;
                        String re = registerPageController.confirmPasswordController.text;
                        String em = registerPageController.emailController.text;
                        String ps = registerPageController.passwordController.text;

                        if (nm.length < 3) {
                          EasyLoading.showToast("Nombre no valido...");
                          return;
                        }

                        if (em.length < 3 || !registerPageController.isValidEmail(em)) {
                          EasyLoading.showToast("Correo no valido...");
                          return;
                        }

                        if (ps.length < 3) {
                          EasyLoading.showToast("Contraseña no valida...");
                          return;
                        }

                        if (re.length < 3) {
                          EasyLoading.showToast("Confiramción de contraseña no valida...");
                          return;
                        }

                        if (re != ps) {
                          EasyLoading.showToast("La contraseña y la confirmación de contraseña no son iguales...");
                          return;
                        }

                        EasyLoading.show(status: 'Cargando...');
                        await Future.delayed(const Duration(milliseconds: 1200),
                                () async {
                              EasyLoading.dismiss();
                            });
                        /*
                        await Future.delayed(const Duration(milliseconds: 1200),
                                () async {
                              await x.pushRegister(nm.trim(), em.trim(), ps.trim());
                              EasyLoading.dismiss();

                              Future.delayed(const Duration(milliseconds: 900), () async {
                                dynamic member = x.userLogin;
                                if (member['id_install'] != '' &&
                                    member['is_member'] == '1' &&
                                    member['is_login'] == '1') {
                                  x.getHome();
                                  Get.back();
                                  EasyLoading.showSuccess(
                                      'Process successful...\nWelcome ${member['fullname']}');
                                }
                              });
                            });
                         */
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.ifYouHaveAccount,
                        style: CustomStyle.textStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          Strings.signIn.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          //signup
                          Get.back();
                          //Get.to(LoginScreen());
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Get.back(closeOverlays: true);
          return false;
        });
  }
}

import 'package:developer_company/data/implementations/user_repository_impl.dart';
import 'package:developer_company/data/models/user_model.dart';
import 'package:developer_company/data/providers/user_provider.dart';
import 'package:developer_company/data/repositories/user_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/utils/permission_level.dart';
import 'package:developer_company/utils/ask_permission.dart';
import 'package:developer_company/views/home/controllers/login_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageController loginPageController = Get.put(LoginPageController());

  final UserRepository userRepository = UserRepositoryImpl(UserProvider());
  bool successLogin = true;
  String badLogin = "usuario o contraseña invalida";

  @override
  void initState() {
    super.initState();
  }

  final httpAdapter = HttpAdapter();

  Future<bool> _loginUser(ProviderContainer container) async {
    try {
      User user = await userRepository.loginUser(
          loginPageController.emailController.value.text,
          loginPageController.passwordController.value.text);

      container.read(userProvider.notifier).setUser(user);
      loginPageController.emailController.clear();
      loginPageController.passwordController.clear();
      return true;
    } catch (e) {
      setState(() {
        badLogin = "Email o contraseña invalida.";
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = ProviderContainer();
    Responsive responsive = Responsive.of(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back, size: 28, color: Colors.black54),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0.25,
            backgroundColor: const Color(0xfff5f6fa),
            title: Text(
              Strings.signIn.toUpperCase(),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  left: responsive.wp(5), right: responsive.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !successLogin
                      ? Text(
                          badLogin,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.redColor),
                        )
                      : const Text(""),
                  SizedBox(height: responsive.hp(2)),
                  const Text(
                    "Correo electrónico",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  TextFormField(
                    style: CustomStyle.textStyle,
                    controller: loginPageController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return Strings.pleaseFillOutTheField;
                      } else if (!loginPageController.isValidEmail(value)) {
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
                      controller: loginPageController.passwordController,
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
                            loginPageController.passwordVisibility.value =
                                !loginPageController.passwordVisibility.value;
                          },
                          icon: loginPageController.passwordVisibility.value
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
                      obscureText: !loginPageController.passwordVisibility.value,
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.marginSize,
                        right: Dimensions.marginSize),
                    child: GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius))),
                        child: Center(
                          child: Text(
                            Strings.signInAccount.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.largeTextSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () async {
                        String em = loginPageController.emailController.text;
                        String ps = loginPageController.passwordController.text;

                        if (em.length < 3 ||
                            !loginPageController.isValidEmail(em)) {
                          EasyLoading.showToast("Correo electrónico inválido");
                          return;
                        }

                        if (ps.length < 3) {
                          EasyLoading.showToast("Contraseña inválida");
                          return;
                        }

                        EasyLoading.show(status: 'Cargando...');
                        EasyLoading.show(status: 'Cargando...');
                        await Future.delayed(const Duration(milliseconds: 1200),
                            () async {
                          EasyLoading.dismiss();
                          final loginResult = await _loginUser(container);
                          if (loginResult) {
                            final haveAccess =
                                AskPermission(PermissionLevel.marketingInitial);
                            if (haveAccess) {
                              Get.toNamed(
                                  RouterPaths.MARKETING_CARROUSEL_ALBUMS);
                            } else {
                              Get.toNamed(RouterPaths.DASHBOARD_PAGE);
                            }
                          }
                          setState(() {
                            successLogin = loginResult;
                          });
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
                        Strings.ifYouHaveNoAccount,
                        style: CustomStyle.textStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          Strings.createAccount.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          //signup
                          Get.back();
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

import 'dart:convert';

import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/is_valid_password.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/views/home/controllers/reset_password_controller.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ResetPasswordDialog extends StatefulWidget {
  ResetPasswordDialog({Key? key}) : super(key: key);

  @override
  _ResetPasswordDialogState createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  ResetPasswordController resetPasswordController = ResetPasswordController();
  bool _showPassword = false;
  final _formResetPassword = GlobalKey<FormState>();
  String failUpdatePassword = "";
  bool isLoading = false;
  bool _isShowPasswordNew = true;
  bool _showSecurityRulesPassword = false;
  HttpAdapter http = HttpAdapter();

  List<String> str = [
    "Al menos 8 letras",
    "Un numero",
    "Un carácter especial como !#\$%^.@",
    "Una letra mayúscula"
  ];

  _doResetPassword() async {
    if (_formResetPassword.currentState!.validate()) {
      final response = await http.postApi(
          "orders/v1/reset-password",
          json.encode({
            "oldPassword": resetPasswordController.oldPassword.text,
            "newPassword": resetPasswordController.newPassword.text,
            "email": resetPasswordController.emailController.text
          }),
          {'Content-Type': 'application/json'});

      final statusCode = response.statusCode;

      if (statusCode != 200) {
        if (response.body.contains("New password should not be the same")) {
          setState(() {
            failUpdatePassword =
                "La contraseña nueva no puede ser igual a la actual";
          });
        } else if (response.body.contains("email or password invalid")) {
          setState(() {
            failUpdatePassword = "Email o contraseña invalida.";
          });
        } else {
          setState(() {
            failUpdatePassword = "Algo salio mal";
          });
        }
        return;
      }
      EasyLoading.showSuccess("Cambio de contraseña exitoso.", duration: Duration(seconds: 15));
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text("Reiniciar contraseña"),
      content: Form(
        key: _formResetPassword,
        child: SingleChildScrollView(
          child: Column(children: [
            if (failUpdatePassword.length > 0)
              Text(
                failUpdatePassword,
                style: TextStyle(
                    color: AppColors.redColor,
                    fontSize: Dimensions.largeTextSize),
              ),
            CustomInputWidget(
              controller: resetPasswordController.emailController,
              label: "Correo electrónico",
              hintText: "Correo",
              prefixIcon: Icons.email,
              validator: ((value) => emailValidator(value)),
            ),
            CustomInputWidget(
              obscureText: !_showPassword,
              controller: resetPasswordController.oldPassword,
              label: "Contraseña Actual",
              hintText: "Contraseña Actual",
              prefixIcon: Icons.password_sharp,
              validator: (value) => notEmptyFieldValidator(value),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: !_showPassword
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
            const Divider(
              height: 20,
              thickness: 2,
              indent: 2,
              endIndent: 2,
              color: AppColors.softMainColor,
            ),
            CustomInputWidget(
              obscureText: _isShowPasswordNew,
              controller: resetPasswordController.newPassword,
              label: "Contraseña nueva",
              hintText: "Contraseña nueva",
              prefixIcon: Icons.password,
              validator: ((value) {
                final isValid = isPasswordValid(value);
                if (isValid != null) {
                  _showSecurityRulesPassword =
                      isValid.toString().contains("patron de seguridad");
                  setState(() {});
                  return isValid;
                }
                _showSecurityRulesPassword = false;
                setState(() {});
                return null;
              }),
            ),
            CustomInputWidget(
              obscureText: _isShowPasswordNew,
              controller: resetPasswordController.newPasswordConfirm,
              label: "Repetir contraseña",
              hintText: "Repetir contraseña",
              prefixIcon: Icons.password,
              validator: (value) {
                if (value != resetPasswordController.newPassword.text)
                  return "Contraseñas no coinciden";
                if (value!.length == 0 ||
                    resetPasswordController.newPassword.text.length == 0)
                  return "Contraseña no puede estar vacía";

                return null;
              },
            ),
            SwitchListTile(
              title: Text(
                !_isShowPasswordNew ? 'Ocultar' : "Ver",
                style: TextStyle(color: Colors.black),
              ),
              value: _isShowPasswordNew,
              onChanged: (bool value) {
                setState(() {
                  _isShowPasswordNew = value;
                });
              },
              activeColor: AppColors.softMainColor,
            ),
            if (_showSecurityRulesPassword)
              Text(
                "Patron de seguridad valido",
                style: TextStyle(fontSize: Dimensions.largeTextSize),
              ),
            if (_showSecurityRulesPassword)
              ...str.map((element) {
                return Row(children: [
                  Text(
                    "\u2022",
                    style: TextStyle(
                        fontSize: Dimensions.extraSmallTextSize,
                        color: Colors.black),
                  ), //bullet text
                  SizedBox(
                    width: 10,
                  ), //space between bullet and text
                  Expanded(
                    child: Text(
                      element,
                      style: TextStyle(
                          fontSize: Dimensions.smallTextSize,
                          color: Colors.black),
                    ), //text
                  )
                ]);
              }).toList()
          ]),
        ),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Aceptar",
          isLoading: isLoading,
          onPress: () async => _doResetPassword(),
        ),
        ElevatedCustomButton(
          color: AppColors.secondaryMainColor,
          text: "Cerrar",
          isLoading: isLoading,
          onPress: () => Navigator.pop(context, false),
        )
      ],
    );
  }
}

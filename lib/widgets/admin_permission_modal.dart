import 'dart:convert';

import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:developer_company/widgets/generic_modal.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PermissionAdminModal extends StatefulWidget {
  final double alertHeight;
  final double alertWidth;
  final VoidCallback? onTapFunction;

  PermissionAdminModal({
    required this.alertHeight,
    required this.alertWidth,
    this.onTapFunction,
  });

  @override
  State<PermissionAdminModal> createState() => _PermissionAdminModalState();
}

class _PermissionAdminModalState extends State<PermissionAdminModal> {
  final GlobalKey<FormState> _formKeyAdminPermission = GlobalKey<FormState>();
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final httpAdapter = HttpAdapter();
  bool _showPassword = false;

  Future<bool> validateUser() async {
    try {
      final response = await httpAdapter.postApi(
          "orders/v1/signin",
          {"email": controllerUser.text, "password": controllerPassword.text},
          {});
      if (response.statusCode != 200) return false;
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final token = responseData['token'] as String?;
      return (token != null);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericModal(
      alertHeight: widget.alertHeight,
      alertWidth: widget.alertWidth,
      title: 'Permiso Administrador',
      child: Form(
        key: _formKeyAdminPermission,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputWidget(
                  validator: (value) => emailValidator(value),
                  controller: controllerUser,
                  label: "Usuario",
                  hintText: "Usuario",
                  prefixIcon: Icons.person_outline),
              CustomInputWidget(
                obscureText: !_showPassword,
                controller: controllerPassword,
                label: "Contraseña",
                hintText: "Contraseña",
                prefixIcon: Icons.person_outline,
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
              )
            ],
          ),
        ),
      ),
      actions: Row(
        children: [
          Expanded(
            child: CustomButtonWidget(
                text: "Cancelar", onTap: () => Navigator.of(context).pop()),
          ),
          Expanded(
            child: CustomButtonWidget(
                text: "Aceptar",
                onTap: () async {
                  if (_formKeyAdminPermission.currentState!.validate()) {
                    final resultOfPermission = await validateUser();
                    if (resultOfPermission &&
                        controllerUser.text.contains("admin@mailinator.com")) {
                      Navigator.of(context).pop();
                      widget.onTapFunction?.call();
                    } else {
                      EasyLoading.showError(
                          "Usuario, contraseña o role no valido para esta operación");
                    }
                  } else {
                    EasyLoading.showError(Strings.pleaseVerifyInputs);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

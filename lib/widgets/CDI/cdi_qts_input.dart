import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/utils/selected_icon.dart';
import 'package:flutter/material.dart';
import 'package:developer_company/utils/cdi_components.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';



class InputWidget extends StatelessWidget {
  final String id;
  final TextEditingController controller;
  final String defaultValue;

  const InputWidget({
    required this.id,
    required this.controller,
    required this.defaultValue,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = defaultValue;
    return CustomInputWidget(
      controller: controller,
      label: "Place_holder",
      hintText: "Place_holder",
      keyboardType: TextInputType.text,
      prefixIcon: selectedIcon("Icon"),
    );
  }
}
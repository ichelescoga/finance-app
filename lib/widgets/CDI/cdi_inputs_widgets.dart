import 'package:flutter/material.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:developer_company/utils/selected_icon.dart';
import 'package:developer_company/utils/get_keyboard_type_from_string.dart';
import 'package:developer_company/data/models/image_model.dart';

Widget buildDropdownWidget(Map<String, dynamic> widgetEP, String id, Map<String, TextEditingController> controllers) {
  TextEditingController controller = TextEditingController(
      text: widgetEP["defaultValue"] != null ? widgetEP["defaultValue"] : "");
  controllers[id] = controller;

  return AutocompleteDropdownWidget(
    listItems: widgetEP["dropdownValues"] as List<DropDownOption>,
    onSelected: (selected) {
      List<DropDownOption> options =
          widgetEP["dropdownValues"] as List<DropDownOption>;

      final selectedClientDropdown = options.firstWhere(
          (element) => element.id == selected.id);
      controller.text = selectedClientDropdown.id;
    },
    label: "Empresas",
    hintText: "Buscar Empresas",
    onFocusChange: ((p0) {}),
    onTextChange: (p0) async {
      List<DropDownOption> options =
          widgetEP["dropdownValues"] as List<DropDownOption>;
      return options
          .where((element) =>
              element.label.toLowerCase().contains(p0.toLowerCase()))
          .toList();
    },
  );
}

Widget buildImageWidget(Map<String, dynamic> widgetEP, String id, Map<String, ImageToUpload> imageControllers) {
  ImageToUpload imageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

  if (widgetEP["defaultValue"] != null) {
    imageController.updateLink(widgetEP["defaultValue"]);
  }

  imageControllers[id] = imageController;
  return LogoUploadWidget(
      uploadImageController: imageController,
      text: widgetEP["Place_holder"],
      icon: selectedIconForImage(widgetEP["Icon"]),
      validator: (value) => null);
}

Widget buildInputWidget(Map<String, dynamic> widgetEP, String id, Map<String, TextEditingController> controllers) {
  TextEditingController controller = TextEditingController(
      text: widgetEP["defaultValue"] != null ? widgetEP["defaultValue"] : "");
  controllers[id] = controller;
  return CustomInputWidget(
    controller: controller,
    label: widgetEP["Place_holder"],
    hintText: widgetEP["Place_holder"],
    keyboardType: getKeyboardTypeFromString(widgetEP["InputType"]),
    prefixIcon: selectedIcon(widgetEP["Icon"]),
  );
}
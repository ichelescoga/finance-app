import 'dart:convert';

import 'package:developer_company/utils/cdi_components.dart';
import 'package:developer_company/widgets/departments_municipalities_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';
import 'package:developer_company/utils/selected_icon.dart';
import 'package:developer_company/utils/get_keyboard_type_from_string.dart';
import 'package:developer_company/data/models/image_model.dart';

Widget buildDropdownWidget(Map<String, dynamic> widgetEP, String id,
    Map<String, TextEditingController> controllers) {
  TextEditingController controller = TextEditingController(
      text: widgetEP["defaultValue"] != null ? widgetEP["defaultValue"] : "");
  controllers[id] = controller;

  return AutocompleteDropdownWidget(
    listItems: widgetEP["dropdownValues"] as List<DropDownOption>,
    onSelected: (selected) {
      List<DropDownOption> options =
          widgetEP["dropdownValues"] as List<DropDownOption>;

      final selectedClientDropdown =
          options.firstWhere((element) => element.id == selected.id);
      controller.text = selectedClientDropdown.id;
    },
    label: widgetEP["Place_holder"]!,
    hintText: widgetEP["Place_holder"]!,
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

Widget buildImageWidget(Map<String, dynamic> widgetEP, String id,
    Map<String, ImageToUpload> imageControllers) {
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
      text: widgetEP["Place_holder"]!,
      icon: selectedIconForImage(widgetEP["Icon"]),
      validator: (value) => null);
}

Widget buildInputWidget(Map<String, dynamic> widgetEP, String id,
    Map<String, TextEditingController> controllers) {
  TextEditingController controller = TextEditingController(
      text: widgetEP["defaultValue"] != null ? widgetEP["defaultValue"] : "");
  controllers[id] = controller;
  return CustomInputWidget(
    controller: controller,
    label: widgetEP["Place_holder"]!,
    hintText: widgetEP["Place_holder"]!,
    keyboardType: getKeyboardTypeFromString(widgetEP["InputType"]),
    prefixIcon: selectedIcon(widgetEP["Icon"]),
  );
}

Widget buildNoShowWidget(Map<String, dynamic> widgetEP, String id,
    Map<String, TextEditingController> controllers) {
  TextEditingController controller = TextEditingController(
      text: widgetEP["defaultValue"] != null ? widgetEP["defaultValue"] : "");
  controllers[id] = controller;
  return Container();
}

Widget buildTwoDropDownCascade(Map<String, dynamic> widgetEP, String id,
    Map<String, TextEditingController> controllers, List<dynamic> formWidgets) {
  TextEditingController fatherController = TextEditingController(
      text: widgetEP["defaultValue"] != null ? widgetEP["defaultValue"] : "");
  controllers[id] = fatherController;
  //? bodyKey = id;

  String fatherId =
      json.decode(widgetEP["listKeys"].toString())["id"].toString();
  // search for set childrenController
  dynamic childrenWidgetEP = formWidgets.firstWhere(
      (element) => element["Type"] == CDIConstants.twoCascadeDropdown && json.decode(element["listKeys"])["id"] == fatherId && json.decode(element["listKeys"])!["level"] == "children");

  if (childrenWidgetEP == null)
    throw Exception(
        "missing children in dropdownCascade ${widgetEP["listKeys"].toString()}");

  TextEditingController childrenController = TextEditingController(
      text: childrenWidgetEP["defaultValue"] != null
          ? childrenWidgetEP["defaultValue"]
          : "");
  controllers[id] = childrenController;

  return TwoDropdownCascade(
    childrenDropdownKeys: childrenWidgetEP["listKeys"],
    fatherOptions: widgetEP["dropdownValues"] as List<DropDownOption>,
    onSelectedFather: "",
    defaultSelectedFather: widgetEP["defaultValue"],
    childrenDropdownEndpoint: childrenWidgetEP["url"],
    childrenController: childrenController,
    onFatherSelectedId: (fatherSelectedId) {
      childrenController.clear();
      List<DropDownOption> options =
          widgetEP["dropdownValues"] as List<DropDownOption>;

      final selectedClientDropdown =
          options.firstWhere((element) => element.id == fatherSelectedId);
      fatherController.text = selectedClientDropdown.id;
      
      
      
      // LOGIC FOR UPDATE THE CONTROLLER VALUE ON DEPARTMENT
    },

    onChildrenSelected: (municipalityId) {

    },
    // LOGIC FOR UPDATE THE CONTROLLER VALUE ON MUNICIPALITY QTS_DepartmentMunicipality
  );
}

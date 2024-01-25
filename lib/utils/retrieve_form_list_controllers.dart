import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/utils/cdi_components.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> retrieveFormControllersInput(
  List<dynamic> formWidgets,
  Map<String, TextEditingController> controllers,
) {
  Map<String, String> values = {};

  formWidgets.forEach((widget) {
    String id = widget["bodyKey"];
    final controller = controllers[id];
    if (widget["Type"] == CDIConstants.input) {
      if (controller == null)
        throw Exception("Controller doesn't have null. ${id}");
      values[id] = controller.text;
    }
  });

  return values;
}

Map<String, ImageToUpload> retrieveFormControllersImage(
  List<dynamic> formWidgets,
  Map<String, ImageToUpload> controllers,
) {
  Map<String, ImageToUpload> values = {};

  formWidgets.forEach((widget) {
    String id = widget["bodyKey"];
    final controller = controllers[id];

    if (widget["Type"] == CDIConstants.image) {
      if (controller == null)
        throw Exception("Controller doesn't have null. ${id}");
      values[id] = controller;
    }
  });

  return values;
}

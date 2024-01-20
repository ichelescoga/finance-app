import 'package:flutter/material.dart';

Map<String, dynamic> retrieveFormControllers(
    List<dynamic> formWidgets, Map<String, TextEditingController> controllers) {
  Map<String, String> values = {};

  formWidgets.forEach((widget) {
    String id = widget["bodyKey"];
    final controller = controllers[id];
    if (controller == null)
      throw Exception("Controller doesn't have null. ${id}");
    values[id] = controller.text;
  });

  return values;
}

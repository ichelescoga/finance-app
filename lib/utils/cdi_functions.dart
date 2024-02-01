import 'dart:convert';

import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/utils/cdi_components.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';

Future<List<Map<String, dynamic>>> fetchDataFormByID(
    List<Map<String, dynamic>> fields,
    dynamic id,
    Future<dynamic> Function(dynamic data) callBack) async {
  dynamic data = {};
  // final dataId = id;
  final customInputs = fields;

  if (id != null) {
    final companyResult = await callBack(id);
    data = companyResult;
    customInputs.forEach((element) {
      // IF THE RESPONSE HAS NOT GOOG PROPERLY FAILS.
      element["defaultValue"] = data[element["bodyKey"]].toString();
    });
  }
  return customInputs;
}

Future processDataForm(
  List<dynamic> formCustomWidgets,
  String? id,
  Future<dynamic> Function(dynamic data) callBack,
) async {
  HttpAdapter http = HttpAdapter();
  List<dynamic> inputs = formCustomWidgets;

  for (var element in inputs) {
    if (element["Type"] == CDIConstants.dropdown) {
      final response = await http.getApi(element["url"], {});
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        final listKeys = element["listKeys"]!.split(",");
        List<DropDownOption> options = jsonData
            .map((e) => DropDownOption(
                id: e[listKeys[0]].toString(), label: e[listKeys[1]]))
            .toList();
        element["dropdownValues"] = options;
      } else {
        throw Exception("Failed to load data");
      }
    }
  }

  List<Map<String, dynamic>> convertedInputs = List<Map<String, dynamic>>.from(inputs);
  final result = await fetchDataFormByID(convertedInputs, id, callBack);
  return result;
}

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
  List<dynamic> inputs = formCustomWidgets;

  for (var element in inputs) {
    if (element["Type"] == CDIConstants.dropdown) {
      List<DropDownOption> options =
          await getDropdownOptions(element["url"], element["listKeys"]);
      element["dropdownValues"] = options;
    }
    if (element["Type"] == CDIConstants.twoCascadeDropdown &&
        element["listKeys"].toString().contains("father")) {    
      List<DropDownOption> options =
          await getDropdownOptions(element["url"], element["listKeys"]);
      element["dropdownValues"] = options;
    }
  }

  List<Map<String, dynamic>> convertedInputs =
      List<Map<String, dynamic>>.from(inputs);
  final result = await fetchDataFormByID(convertedInputs, id, callBack);
  return result;
}

Future<List<DropDownOption>> getDropdownOptions(
    String endpoint, String? keys) async {
  HttpAdapter http = HttpAdapter();

  final response = await http.getApi(endpoint, {});
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    final listKeys = json.decode(keys.toString());
    List<DropDownOption> options = jsonData
        .map((e) => DropDownOption(
            id: e[listKeys["key1"]].toString(), label: e[listKeys["key2"]]))
        .toList();
    return options;
  } else {
    return [];
  }
}

import 'dart:convert';

import 'package:developer_company/data/models/CDI/custom_dropdown_model.dart';
import 'package:developer_company/data/models/CDI/custom_image_model.dart';
import 'package:developer_company/data/models/CDI/custom_input_model.dart';
import 'package:developer_company/data/models/CDI/custom_table_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class CDIProvider {
  final http = HttpAdapter();

  Future<List<dynamic>> fetchCompanyTable() async {
    final endpoint = "orders/v1/getComponentsByEntity";

    try {
      final response = await http.getApiWithBody(endpoint, {'Content-Type': 'application/json'}, {"id": 1});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((item) {
            return item[0];
            // switch (item[0]["Type"]) {
            //   case "QTS_Table":
            //     return QTS_Table.fromJson(item[0]);
            //   case "QTS_Input":
            //     return QTS_input.fromJson(item[0]);
            //   case "QTS_Image":
            //     return QTS_image.fromJson(item[0]);
            //   case "QTS_Dropdown":
            //     return QTS_dropdown.fromJson(item[0]);
            //   default:
            //     throw Exception("Unknown type: ");
            // }
          }).toList();
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}

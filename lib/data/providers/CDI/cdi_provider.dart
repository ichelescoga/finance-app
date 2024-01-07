import 'dart:convert';

import 'package:developer_company/data/models/CDI/custom_dropdown_model.dart';
import 'package:developer_company/data/models/CDI/custom_image_model.dart';
import 'package:developer_company/data/models/CDI/custom_input_model.dart';
import 'package:developer_company/data/models/CDI/custom_table_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class CDI_QTS_provider {
  final http = HttpAdapter();

  Future<List<dynamic>> fetchCompanyTable(String type) async {
    // You can customize the endpoint (EP) based on your requirements
    final endpoint =
        "https://example.com/api/$type"; // Replace with your actual API endpoint

    try {
      final response = await http.getApi(endpoint, {}, {"id": 1});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((item) {
            switch (type) {
              case "QTS_Table":
                return QTS_Table.fromJson(item);
              case "QTS_input":
                return QTS_input.fromJson(item);
              case "QTS_image":
                return QTS_image.fromJson(item);
              case "QTS_dropdown":
                return QTS_dropdown.fromJson(item);
              default:
                throw Exception("Unknown type: $type");
            }
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

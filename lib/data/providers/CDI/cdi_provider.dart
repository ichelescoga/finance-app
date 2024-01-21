import 'dart:convert';

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

import 'dart:convert';

import 'package:developer_company/shared/utils/http_adapter.dart';

class CDIProvider {
  final http = HttpAdapter();

  Future<List<dynamic>> fetchDataTable(String entity) async {
    final endpoint = "orders/v1/getComponentsByEntity";

    try {
      final response = await http.getApiWithBody(
          endpoint, {'Content-Type': 'application/json'}, {"id": entity});

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

  Future<List<dynamic>> fetchDataList(String endpoint) async {
    final response = await http.getApi(endpoint, {});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        return jsonData;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<dynamic> getDataById(String endpoint, String id) async {
    final response = await http.getApi('${endpoint}/${id}', {});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'failed to get data by id ENDPOINT = ${endpoint} ID = ${id}');
    }
  }

  Future<bool> postData(String url, Map<String, dynamic> data) async {
    final response = await http
        .postApi(url, json.encode(data), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editData(String url, Map<String, dynamic> data) async {
    final response = await http
        .putApi(url, json.encode(data), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

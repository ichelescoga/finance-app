import 'dart:convert';
import 'package:developer_company/data/models/analyst_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class AnalystProvider {
  final httpAdapter = HttpAdapter();

  Future<List<AnalystQuotation>> fetchAllQuotesForAnalyst(String projectId) async {
    final response =
        await httpAdapter.getApi("orders/v1/cotizacionesAnalista/$projectId", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      final dataResult = jsonResponse
          .map((json) => AnalystQuotation.fromJson(json))
          .toList();

      return dataResult;
    } else if (response.statusCode == 202) {
      return [];
    } else {
      throw Exception('Failed to fetch companies');
    }
  }
}

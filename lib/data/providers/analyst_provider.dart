import 'dart:convert';
import 'package:developer_company/data/models/analyst_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class AnalystProvider {
  final httpAdapter = HttpAdapter();

  Future<List<AnalystQuotation>> fetchAllQuotesForAnalyst() async {
    final response =
        await httpAdapter.getApi("orders/v1/cotizacionesAnalista", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((json) => AnalystQuotation.fromJson(json))
          .toList();
    } else if (response.statusCode == 202) {
      return [];
    } else {
      throw Exception('Failed to fetch companies');
    }
  }
}

import 'dart:convert';

import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class UnitQuotationProvider {
  final httpAdapter = HttpAdapter();

  Future<List<UnitQuotation>> fetchUnitQuotationsForQuotation(int quotationId) async {
    final response = await httpAdapter.getApi("orders/v1/cotizacionsUnidad/$quotationId", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => UnitQuotation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch unit quotations for quotation');
    }
  }
}

import 'dart:convert';

import 'package:developer_company/client_rest_api/models/units/client_units_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class ClientUnitProvider {
  final httpAdapter = HttpAdapter();

  Future<List<ClientUnitsModel>> fetchUnits(String clientId) async {
    final response = await httpAdapter
        .getApi("orders/v1/cuentasCorrientesUnidad/${clientId}", {});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> quotes = jsonResponse["data"];

      return quotes.map((e) => ClientUnitsModel.fromJson(e)).toList();
    } else {
      print("Failed to fetch units 🚀🚀🚀");
      return [];
    }
  }
}

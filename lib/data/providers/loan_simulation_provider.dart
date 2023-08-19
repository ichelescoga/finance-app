import 'dart:convert';

import 'package:developer_company/data/models/loan_simulation_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class LoanSimulationProvider {
  final httpAdapter = HttpAdapter();

  Future<List<LoanSimulationResponse?>> simulateLoan(
      LoanSimulationRequest request) async {
    final finalBody = json.encode(request.toJson());

    final response = await httpAdapter.postApi("account/v1/pmtCalculate",
        finalBody, {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((item) => LoanSimulationResponse.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to simulate loan');
    }
  }
}

import 'dart:convert';

import 'package:developer_company/data/models/loan_application_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class LoanApplicationProvider {
  final httpAdapter = HttpAdapter();

  Future<bool> submitLoanApplication(LoanApplication loanApplication) async {
    final response = await httpAdapter.postApi(
        "orders/v1/crearCredito", jsonEncode(loanApplication.toJson()), {
      'Content-Type': 'application/json',
    });

    return response.statusCode == 200;
  }
  
  Future<bool> updateLoanApplication(LoanApplication loanApplication, String applicationId) async {
    final response = await httpAdapter.putApi(
        "orders/v1/actualizarCredito/$applicationId", jsonEncode(loanApplication.toJson()), {
      'Content-Type': 'application/json',
    });

    return response.statusCode == 200;
  }

  Future<LoanApplication?> fetchLoanApplication(String applicationId) async {
    final response = await httpAdapter
        .getApi("orders/v1/credito/$applicationId", {});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return LoanApplication.fromJson(jsonResponse);
    } else if (response.statusCode == 202) {
      return null;
    } else {
      throw Exception('Failed to fetch unit quotations for quotation');
    }
  }
}

import 'dart:convert';

import 'package:developer_company/client_rest_api/models/payments/resources_payment_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class PaymentResourcesAPI {
  final httpAdapter = HttpAdapter();

  Future<List<BankModel>> fetchBanks() async {
    final response = await httpAdapter.getApi("orders/v1/establecimientos", {});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> banks = jsonResponse["data"];

      return banks.map((e) => BankModel.fromJson(e)).toList();
    } else {
      print("Failed to fetch units 🚀🚀🚀");
      return [];
    }
  }

  Future<List<PaymentTypeModel>> fetchPaymentTypes() async {
    final response = await httpAdapter.getApi("orders/v1/formasPago", {});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> paymentTypes = jsonResponse["data"];

      return paymentTypes.map((e) => PaymentTypeModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}

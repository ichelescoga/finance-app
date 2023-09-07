import 'dart:convert';

import 'package:developer_company/data/models/pre_sell_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class PreSellProvider {
  final httpAdapter = HttpAdapter();

  Future<PreSell> getInfoClientPreSell(String quoteId) async {
    final response =
        await httpAdapter.getApi("orders/v1/infoPreventa/$quoteId", {});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return PreSell.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to simulate pre sell');
    }
  }
}

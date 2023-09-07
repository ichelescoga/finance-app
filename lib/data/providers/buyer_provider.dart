import 'dart:convert';

import 'package:developer_company/data/models/buyer_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class BuyerProvider {
  final httpAdapter = HttpAdapter();

  Future<String?> postSellBuyerData(
    BuyerData buyer,
    String quoteId,
  ) async {
    final response = await httpAdapter
        .postApi("orders/v1/preVentaPdf/$quoteId", jsonEncode(buyer.toJson()), {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);

      return responseMap["body"];
    } else {
      throw Exception('Failed to fetch credits approved reserved');
    }
  }
}

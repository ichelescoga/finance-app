import 'dart:convert';

import 'package:developer_company/data/models/discount_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class DiscountProvider {
  final httpAdapter = HttpAdapter();

  Future<DiscountSeason> getSeasonDiscount(String projectId) async {
    final response =
        await httpAdapter.getApi("orders/v1/descuentos/$projectId", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.length == 0)
        return DiscountSeason(
            discountId: '0',
            discountSeasonId: '0',
            projectId: '0',
            months: '0',
            percentage: 0);
      return DiscountSeason.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to fetch credits approved reserved');
    }
  }
}

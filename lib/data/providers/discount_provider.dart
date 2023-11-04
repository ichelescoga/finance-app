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
            percentage: "0");
      return DiscountSeason.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to fetch season discount');
    }
  }

  Future<List<RequestedDiscount>> getRequestDiscounts(String projectId) async {
    final response =
        await httpAdapter.getApi("orders/v1/requeisitionSoliDesc/$projectId", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((json) => RequestedDiscount.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch discounts for resolution");
    }
  }

  Future<bool> acceptDiscount(String discountId) async {
    final response = await httpAdapter
        .putApi("orders/v1/aprobacionSolicitudDescuento/$discountId", {}, {});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> rejectDiscount(String discountId) async {
    final response = await httpAdapter
        .putApi("orders/v1/denegarSolicitudDescuento/$discountId", {}, {});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<RequestedDiscount>> getDiscountByResolution(
      bool isApproved, String projectId) async {
    final response = await httpAdapter.getApi(
        "orders/v1/stateDescuento/${isApproved ? "1" : "0"}/proyecto/$projectId",
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> jsonResponseList = jsonResponse["message"];
      return jsonResponseList
          .map((json) => RequestedDiscount.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to get discount resolution 🥲");
    }
  }
}

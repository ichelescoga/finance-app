import 'dart:convert';

import 'package:developer_company/data/models/sell_models.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
// import 'package:intl/intl.dart';

class SellProvider {
  final httpAdapter = HttpAdapter();

  Future<StatusOfPayments> getStatusOfPayments(String quoteId) async {
    final response = await httpAdapter.getApi(
        "orders/v1/getStatusOfBookDownPaymentTotalPayment/${quoteId}", {});

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return StatusOfPayments.fromJson(data);
    } else {
      throw Exception("Failed to get status of payments");
    }
  }

  Future<MonetaryDownPayment> getMonetaryDownPayment(String unitId) async {
    final response =
        await httpAdapter.getApi("orders/v1/valorTotalEnganche/$unitId", {});

    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      return MonetaryDownPayment.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<BookModel> getBookModel(String unitId) async {
    final response =
        await httpAdapter.getApi("orders/v1/valorTotalReserva/$unitId", {});

    if (response.statusCode == 200) {
      dynamic finalResponse = jsonDecode(response.body);
      return BookModel.fromJson(finalResponse);
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<bool> postMonetaryDownPayment(String unitId) async {
    final response = await httpAdapter.postApi(
        "orders/v1/createPagoEnganche/$unitId",
        {},
        {});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<bool> postBookModel(String unitId) async {
    final response = await httpAdapter.postApi(
        "orders/v1/createPagoReserva/$unitId",
        {},
        {});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<bool> postMonetaryFee(String quoteId, String interestRate) async {
    final response = await httpAdapter.postApi(
        "orders/v1/createCuotas/$quoteId",
        json.encode({"interes": interestRate}),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }
}

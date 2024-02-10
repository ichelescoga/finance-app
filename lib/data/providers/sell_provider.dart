import 'dart:convert';

import 'package:developer_company/data/models/sell_models.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:intl/intl.dart';

class SellProvider {
  final httpAdapter = HttpAdapter();

  Future<MonetaryDownPayment> getMonetaryDownPayment(int unitId) async {
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

  Future<PayTotalUnitModel> getPayTotalUnit(String unitId) async {
    final response =
        await httpAdapter.getApi("orders/v1/valorTotalReserva/$unitId", {});

    if (response.statusCode == 200) {
      dynamic finalResponse = jsonDecode(response.body);
      return PayTotalUnitModel.fromJson(finalResponse);
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<bool> postMonetaryDownPayment(DateTime initialDate, DateTime finalDate, String projectId, String percentage) async {
    String initialDateString = DateFormat('yyyy-MM-dd').format(initialDate);
    String finalDateString = DateFormat('yyyy-MM-dd').format(finalDate);

    final response = await httpAdapter.postApi(
        "orders/v1/createDetallePorcentajeEnganche",
        json.encode({
          "fechaInicial": initialDateString,
          "fechaFinal": finalDateString,
          "idProyecto": projectId,
          "porcentaje": percentage
        }),
        {'Content-Type': 'application/json'});

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
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      dynamic responseData = response.body;
      return json.decode(responseData["data"]);
    } else {
      throw Exception('Failed to fetch projects');
    }
  }

  Future<bool> postPayTotalUnit(String unitId) async {
    final response = await httpAdapter.postApi(
        "orders/v1/valorTotalReserva/$unitId",
        {},
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to fetch projects');
    }
  }
}

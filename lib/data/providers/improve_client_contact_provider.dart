import 'dart:convert';

import 'package:developer_company/data/models/client_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class ImproveClientContactProvider {
  final httpAdapter = HttpAdapter();

  Future<ClientModel> existContactInClient(
      String phone, String name, String email) async {
    final response = await httpAdapter.postApi(
        "orders/v1/correoCelExistente",
        json.encode({
          "telefono": phone,
          "correo": email,
          "nombre": name,
        }),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ClientModel.fromJson(jsonResponse["body"]["CLIENTE_HAS_CONTACTOs"]
          [0]["Id_cliente_CLIENTE"]);
    } else {
      throw Exception("Failed to get client Info");
    }
  }

  Future<List<ClientModel>> getClientsByKeyword(
      String name, String email) async {
    final response = await httpAdapter.postApi(
        "orders/v1/coincidenciasCredenciales",
        json.encode({"correo": name, "nombre": email}),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> clients = jsonResponse["bodyContactos"];

      return clients
          .where((client) => client["CLIENTE_HAS_CONTACTOs"]!.length > 0)
          .map((client) => ClientModel.fromJson(
              client["CLIENTE_HAS_CONTACTOs"][0]["Id_cliente_CLIENTE"]))
          .toList();
    } else {
      throw Exception("Failed to get client list");
    }
  }
}

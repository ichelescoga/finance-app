import 'dart:convert';
import 'package:developer_company/data/models/client_contact_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class QuickClientContactProvider {
  final httpAdapter = HttpAdapter();

  Future<List<QuickClientContacts>> fetchClientContact(String projectId) async {
    final response =
        await httpAdapter.getApi("orders/v1/contactos/${projectId}", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((json) => QuickClientContacts.fromJson(json))
          .toList();
    } else {
      print("Failed to fetch companies 🚀🚀🚀");
      // throw Exception('Failed to fetch companies');
      return [];
    }
  }

  Future<bool> addNewClientContact(QuickClientContacts contact) async {
    final response = await httpAdapter
        .postApi("orders/v1/crearContacto", json.encode(contact.toJson()), {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editClientContact(QuickClientContacts contact) async {
    final response = await httpAdapter.putApi(
        "orders/v1/actualizarContacto/${contact.contactId}",
        jsonEncode(contact.toJson()),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:convert';
import 'package:developer_company/data/models/user_creation_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class UserCreationProvider {
  final httpAdapter = HttpAdapter();

  Future<void> createUser(UserCreation user) async {
    final response = await httpAdapter.postApi('orders/v1/register',
        jsonEncode(user.toJson()), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // should be return => generalModalResponses.fromJson(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to login');
    }

   
  }
}

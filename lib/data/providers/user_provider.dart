import 'dart:convert';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/data/models/user_model.dart';

class UserProvider {
  final httpAdapter = HttpAdapter();

  Future<User> loginUser(String token) async {
    final headers = {
      'authorization': 'bearer $token',
    };
    final response = await httpAdapter.getApi("orders/v1/user", headers);

    if (response.statusCode == 202) {
      final jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse, token);
    } else {
      throw Exception('Failed to login');
    }
  }
}

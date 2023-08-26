import 'dart:convert';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/data/models/user_model.dart';

class UserProvider {
  final httpAdapter = HttpAdapter();

  Future<User> loginUser(String email, String password) async {
    final response = await httpAdapter.postApi(
        "orders/v1/signin", {"email": email, "password": password}, {});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to login');
    }
  }
}

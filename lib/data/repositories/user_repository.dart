import 'package:developer_company/data/models/user_model.dart';

abstract class UserRepository {
  Future<User> loginUser(String email, String password);
}

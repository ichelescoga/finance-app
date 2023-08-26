import 'package:developer_company/data/models/user_model.dart';
import 'package:developer_company/data/providers/user_provider.dart';
import 'package:developer_company/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserProvider userProvider;

  UserRepositoryImpl(this.userProvider);

  @override
  Future<User> loginUser(String email, String password) async {
    return await userProvider.loginUser(email, password);
  }
}

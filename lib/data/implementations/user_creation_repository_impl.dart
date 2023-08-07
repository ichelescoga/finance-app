import 'package:developer_company/data/models/user_creation_model.dart';
import 'package:developer_company/data/providers/user_create_provider.dart';
import 'package:developer_company/data/repositories/user_create_repository.dart';

class UserCreationRepositoryImpl implements UserCreationRepository {
  final UserCreationProvider userProvider;

  UserCreationRepositoryImpl(this.userProvider);

  @override
  Future<void> createUser(UserCreation user) async {
    await userProvider.createUser(user);
  }
}
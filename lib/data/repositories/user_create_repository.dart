import 'package:developer_company/data/models/user_creation_model.dart';

abstract class UserCreationRepository {
  Future<void> createUser(UserCreation user);
}
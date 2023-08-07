import 'package:developer_company/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(User? state) : super(state);

  void setUser(User user) {
    state = user;
  }
}

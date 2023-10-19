import 'package:developer_company/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(name: "", role: "", token: "", company: Company(companyId: "", companyName: "companyName"), project: Project(projectId: "1", projectName: "")));

  void setUser(User user) {
    state = user;
  }

    String get jwt {
    return state.token;
  }

  String get role {
    return state.role;
  }

  
}

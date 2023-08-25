import 'package:developer_company/shared/utils/role_names.dart';

class User {
  // ! this should be changed
  final String token;
  final String role;
  final String name;

  User({required this.role, required this.name, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    final roleName = roleNamesById[json['usuario']["USER_PROFILEs"][0]["Id_rol"]]!;
    return User(
      token: json['token'],
      role: roleName,
      name: json['usuario']["Nombre"],
    );
  }
}

import 'package:developer_company/shared/utils/role_names.dart';

class User {
  final String token;
  final String role;
  final String name;
  final Company company;
  final Project project;
  final bool needChangePassword;

  User(
      {required this.role,
      required this.name,
      required this.token,
      required this.company,
      required this.project,
      required this.needChangePassword
      });

  factory User.fromJson(Map<String, dynamic> json) {
    final roleName =
        roleNamesById[json['usuario']["USER_PROFILEs"][0]["Id_rol"]]!;
    return User(
        token: json['token'],
        role: roleName,
        name: json['usuario']["Nombre"],
        needChangePassword: json["usuario"]["needUpdatePassword"] == null ? false : json["usuario"]["needUpdatePassword"],
        company: Company.fromJson(json),
        project: Project.fromJson(json));
  }
}
// TODO: REMEMBER PUT THE COMPANY MODEL THIS IS ONLY A TEMP COMPANY MODEL FOR PROJECTS WORKS, FOR AVOID WORKINGS BAD
class Company {
  final String companyId;
  final String companyName;

  Company({required this.companyId, required this.companyName});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        companyId: json["usuario"]["USER_PROFILEs"][0]
                    ["Id_empleado_EMPLEADO_ASESOR"]["EMPLEADO_EMPRESAs"][0]
                ["Id_empresa_EMPRESA"]["Id_empresa"]
            .toString(),
        companyName: json["usuario"]["USER_PROFILEs"][0]
                ["Id_empleado_EMPLEADO_ASESOR"]["EMPLEADO_EMPRESAs"][0]
            ["Id_empresa_EMPRESA"]["Nombre_comercial"]);
  }
}

class Project {
  final String projectId;
  final String projectName;

  Project({required this.projectId, required this.projectName});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        projectId: json["proyecto"]["Id_proyecto"].toString(),
        projectName: json["proyecto"]["Nombre_proyecto"]);
  }
}

class UserClient {
 final String email;
 final String name;
 final String role;
 final String token;

  UserClient({
    required this.email,
    required this.name,
    required this.role,
    required this.token,
  });

  factory UserClient.fromJson(Map<String,dynamic> json){ 
    return UserClient(email: json["email"], name: json["name"], role: json["roleId"], token: json["token"]);
  }

}


class NewUserClient {
  final String email;
  final String password;

  NewUserClient({
    required this.email,
    required this.password
  });

  factory NewUserClient.fromJson(Map<String,dynamic> json){
    return NewUserClient(email: json["user"]["email"], password: json["user"]["password"]);
  }
}

//  "token": token,
//   "roleId": 3,
//   "email": "pablozapetalop@gmail.com",
//   "name": "Pablo Miguel Zapeta Lopez "

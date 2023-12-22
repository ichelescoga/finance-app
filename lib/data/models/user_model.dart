import 'package:developer_company/shared/utils/role_names.dart';

class User {
  final String token;
  final String role;
  final String name;
  final Company company;
  final Project project;

  User(
      {required this.role,
      required this.name,
      required this.token,
      required this.company,
      required this.project});

  factory User.fromJson(Map<String, dynamic> json) {
    final roleName =
        roleNamesById[json['usuario']["USER_PROFILEs"][0]["Id_rol"]]!;
    return User(
        token: json['token'],
        role: roleName,
        name: json['usuario']["Nombre"],
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

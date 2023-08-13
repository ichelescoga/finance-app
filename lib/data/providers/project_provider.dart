import 'dart:convert';
import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';


class ProjectProvider {
  final httpAdapter = HttpAdapter();

  Future<List<Project>> fetchUnitsByProject(int companyId) async {
    final response = await httpAdapter.getApi("orders/v1/UnidadesProyecto/$companyId", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch projects');
    }
  }
}

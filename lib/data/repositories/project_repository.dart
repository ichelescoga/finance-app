
import 'package:developer_company/data/models/project_model.dart';

abstract class ProjectRepository {
  Future<List<Project>> fetchUnitsByProject(int companyId);
  Future<dynamic> getProjectById(String projectId);
}
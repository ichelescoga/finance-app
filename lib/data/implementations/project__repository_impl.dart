import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectProvider projectProvider;

  ProjectRepositoryImpl(this.projectProvider);

  @override
  Future<List<Project>> fetchUnitsByProject(int companyId) async {
    return await projectProvider.fetchUnitsByProject(companyId);
  }

  @override
  Future<dynamic> getProjectById(String projectId) async {
    return await projectProvider.getProjectById(projectId);
  }
}
import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/project_model.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:get/get.dart';

class ExpressRequestController extends GetxController {
  ExpressRequestController(this._projectId);
  final int _projectId;
  final ProjectRepository projectRepository =
      ProjectRepositoryImpl(ProjectProvider());

  RxList<Unit> projectUnits = RxList<Unit>([]);
  RxList<Unit> filteredProjectUnits = RxList<Unit>([]);

  void cleanData() {
    projectUnits.clear();
    filteredProjectUnits.clear();
  }

  Future<void> fetchUnitProjects() async {
    try {
      List<Project> project =
          await projectRepository.fetchUnitsByProject(_projectId);
      projectUnits.addAll(project[0].units);
      filteredProjectUnits.addAll(project[0].units);
    } catch (_) {
    } finally {
      update();
    }
  }

  void setFilterData(List<Unit> data) {
    filteredProjectUnits.clear();
    filteredProjectUnits.addAll(data);
    update();
  }
}

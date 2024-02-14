import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';

class CDIRepositoryImpl implements CDIRepository {
  final CDIProvider cdiProvider;

  CDIRepositoryImpl(this.cdiProvider);

  @override
  Future<List<dynamic>> fetchDataTable(String entity) async {
    return this.cdiProvider.fetchDataTable(entity);
  }

  @override
  Future<List<dynamic>> fetchDataList(String endpoint) async {
    return this.cdiProvider.fetchDataList(endpoint);
  }

  @override
  Future<dynamic> getDataById(String endpoint, String id) async {
    return this.cdiProvider.getDataById(endpoint, id);
  }

  @override
  Future<bool> postData(String url, Map<String, dynamic> data) async {
    return this.cdiProvider.postData(url, data);
  }

  @override
  Future<bool> editData(String url, Map<String, dynamic> data) async {
    return this.cdiProvider.editData(url, data);
  }
}

import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';

class CDIRepositoryImpl implements CDIRepository {
  final CDIProvider cdiProvider;

  CDIRepositoryImpl(this.cdiProvider);

  @override
  Future<List<dynamic>> fetchCompanyTable() async {
    return this.cdiProvider.fetchCompanyTable();
  }

  @override
  Future<List<dynamic>> fetchDataList(String endpoint) async {
    return this.cdiProvider.fetchDataList(endpoint);
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

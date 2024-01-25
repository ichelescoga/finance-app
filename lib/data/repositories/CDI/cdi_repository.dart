abstract class CDIRepository {
  Future<List<dynamic>> fetchCompanyTable();
  Future<List<dynamic>> fetchDataList(String endpoint);
  Future<bool> postData(String url, Map<String, dynamic> data);
  Future<bool> editData(String url, Map<String, dynamic> data);
}

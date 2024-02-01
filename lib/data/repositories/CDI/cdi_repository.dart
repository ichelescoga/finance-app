abstract class CDIRepository {
  Future<List<dynamic>> fetchDataTable(String entity);
  Future<List<dynamic>> fetchDataList(String endpoint);
  Future<dynamic> getDataById(String endpoint, String id);
  Future<bool> postData(String url, Map<String, dynamic> data);
  Future<bool> editData(String url, Map<String, dynamic> data);
}

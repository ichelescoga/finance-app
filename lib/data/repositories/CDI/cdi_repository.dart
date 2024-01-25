
abstract class CDIRepository {
  Future<List<dynamic>> fetchCompanyTable();
  Future<List<dynamic>> fetchDataList(String endpoint);
}

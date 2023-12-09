import 'package:developer_company/data/models/client_model.dart';

abstract class ImproveClientContactRepository {
  Future<ClientModel> existContactInClient(
      String phone, String name, String email);

  Future<List<ClientModel>> getClientsByKeyword(String name, String email);
}

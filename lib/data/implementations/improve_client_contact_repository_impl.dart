import 'package:developer_company/data/models/client_model.dart';
import 'package:developer_company/data/providers/improve_client_contact_provider.dart';
import 'package:developer_company/data/repositories/improve_client_contact_repository.dart';

class ImproveClientContactRepositoryImpl
    implements ImproveClientContactRepository {
  final ImproveClientContactProvider improveClientContactProvider;

  ImproveClientContactRepositoryImpl(this.improveClientContactProvider);

  @override
  Future<ClientModel> existContactInClient(
      String phone, String name, String email) async {
    return await improveClientContactProvider.existContactInClient(
        phone, name, email);
  }

  @override
  Future<List<ClientModel>> getClientsByKeyword(
      String name, String email) async {
    return await improveClientContactProvider.getClientsByKeyword(name, email);
  }
}

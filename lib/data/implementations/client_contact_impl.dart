import 'package:developer_company/data/models/client_contact_model.dart';
import 'package:developer_company/data/providers/client_contact_provider.dart';
import 'package:developer_company/data/repositories/client_contact_repository.dart';

class QuickClientContactRepositoryImpl implements QuickClientContactRepository {
  final QuickClientContactProvider quickClientContactProvider;

  QuickClientContactRepositoryImpl(this.quickClientContactProvider);

  @override
  Future<List<QuickClientContacts>> fetchClientContact(String projectId) async {
    return await this.quickClientContactProvider.fetchClientContact(projectId);
  }

  @override
  Future<bool> addNewClientContact(QuickClientContacts contact) async {
    return await this.quickClientContactProvider.addNewClientContact(contact);
  }

  @override
  Future<bool> editClientContact(QuickClientContacts contact) async {
    return await this.quickClientContactProvider.editClientContact(contact);
  }
}

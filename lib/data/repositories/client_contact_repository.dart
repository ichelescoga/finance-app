

import 'package:developer_company/data/models/client_contact_model.dart';

abstract class QuickClientContactRepository {
  Future<List<QuickClientContacts>> fetchClientContact(String projectId);
  Future<bool>addNewClientContact(QuickClientContacts contact);
  Future<bool>editClientContact(QuickClientContacts contact);
}
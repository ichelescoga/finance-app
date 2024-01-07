import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';

class CDIRepositoryImpl implements CDIRepository {
  final CDIProvider cdiProvider;

  CDIRepositoryImpl(this.cdiProvider);

  @override
  Future<List<dynamic>> fetchCompanyTable() async {
    return this.cdiProvider.fetchCompanyTable();
  }
}

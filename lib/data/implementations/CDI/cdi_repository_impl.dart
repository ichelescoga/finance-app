import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';

class CDI_Repository_Impl implements CDI_Repository {
  final CDI_QTS_provider cdiProvider;

  CDI_Repository_Impl(this.cdiProvider);

  @override
  Future<List<dynamic>> fetchCompanyTable(String type) async {
    return this.cdiProvider.fetchCompanyTable(type);
  }
}

import 'package:developer_company/data/models/analyst_model.dart';
import 'package:developer_company/data/providers/analyst_provider.dart';
import 'package:developer_company/data/repositories/analyst_repository.dart';

class AnalystRepositoryImpl implements AnalystRepository {
  final AnalystProvider analystProvider;

  AnalystRepositoryImpl(this.analystProvider);

  @override
  Future<List<AnalystQuotation>> fetchAllQuotesForAnalyst() async {
    return await analystProvider.fetchAllQuotesForAnalyst();
  }
}

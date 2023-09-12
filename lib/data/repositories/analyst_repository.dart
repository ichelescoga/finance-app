

import 'package:developer_company/data/models/analyst_model.dart';

abstract class AnalystRepository {
  Future<List<AnalystQuotation>> fetchAllQuotesForAnalyst(String projectId);
}
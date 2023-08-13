
import 'package:developer_company/data/models/company_model.dart';

abstract class CompanyRepository {
  Future<List<Company>> fetchCompanies();
}
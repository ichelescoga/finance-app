import 'package:developer_company/data/models/company_model.dart';

abstract class CompanyRepository {
  Future<List<dynamic>> fetchCompanies();
  Future<bool> createCompany(Company company);
  Future<bool> editCompany(int companyId, Company company);
  Future<bool> deleteCompany(int companyId);
   Future<dynamic> getCompanyById(int companyId);
}

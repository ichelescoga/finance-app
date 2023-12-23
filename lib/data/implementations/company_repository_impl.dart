
import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyProvider companyProvider;

  CompanyRepositoryImpl(this.companyProvider);

  @override
  Future<List<Company>> fetchCompanies() async {
    return companyProvider.fetchCompanies();
  }

  @override
  Future<bool> createCompany(Company company) async { 
    return this.createCompany(company);
  }
  @override
  Future<bool> editCompany(int companyId, Company company) async { 
    return this.editCompany(companyId, company);
  }
}
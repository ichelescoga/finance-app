
import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyProvider companyProvider;

  CompanyRepositoryImpl(this.companyProvider);

  @override
  Future<List<Company>> fetchCompanies() async {
    return await this.companyProvider.fetchCompanies();
  }

  @override
  Future<bool> createCompany(Company company) async { 
    return await this.companyProvider.createCompany(company);
  }

  @override
  Future<bool> editCompany(int companyId, Company company) async { 
    return await this.companyProvider.editCompany(companyId, company);
  }

  @override
   Future<bool> deleteCompany(int companyId) async  {
    return await this.companyProvider.deleteCompany(companyId);
   }

   @override
    Future<dynamic> getCompanyById(int companyId) async {
      return await this.companyProvider.getCompanyById(companyId);
    }
}
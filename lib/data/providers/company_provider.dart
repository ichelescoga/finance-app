import 'dart:convert';
import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/utils/convertArrayToObject.dart';

class CompanyProvider {
  final httpAdapter = HttpAdapter();

  Future<List<Company>> fetchCompanies() async {
    final response = await httpAdapter.getApi("orders/v1/getCompanies", {});

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse.map((json) {
        final companyDetails = convertArrayToObject(json['details']);

        return Company.fromJson({...json, ...companyDetails});
      }).toList();
    } else {
      throw Exception('Failed to fetch companies');
    }
  }

  Future<bool> createCompany(Company company) async {
    final response = await httpAdapter.postApi("orders/v1/addCompany",
        jsonEncode(company.toJson()), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add new company');
    }
  }

  Future<bool> editCompany(int companyId, Company company) async {
    company.companyId = companyId;

    final response = await httpAdapter.postApi("orders/v1/addCompany",
        jsonEncode(company.toJson()), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add new company');
    }
  }

  Future<bool> deleteCompany(int companyId) async {
    final response = await httpAdapter.postApi(
        "orders/v1/deleteCompany",
        jsonEncode({
          "id": companyId,
          "updatedby": DateTime.now()
        }),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete company");
    }
  }

  Future<Company> getCompanyById(int companyId) async {

    final response = await httpAdapter.getApi("orders/v1/getCompanyById", {});
    if(response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final companyDetails = convertArrayToObject(jsonResponse['details']);

      return Company.fromJson({...jsonResponse, ...companyDetails});
    }else {
      throw Exception("Failed to get company");
    }

  }
}

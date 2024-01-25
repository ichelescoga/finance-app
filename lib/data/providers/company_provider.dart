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
// TODO: now response with plain objects 
/*

{
    "nombre": "Skyline Heights Realty",
    "descripcion": "Elevando el estándar de vida en lo más alto de la ciudad.",
    "desarrollador": "Altitude Developers",
    "nit": "8901234",
    "direccion": "Horizonte Urbano #901",
    "contacto": "Laura Soto",
    "telefonocontacto": "10987654",
    "gerentedeventas": "Diego Muñoz",
    "telefonogerente": "09876543",
    "logo": "[Enlace al logo]"
  }
   */
      return jsonResponse.map((json) {
        final companyDetails = convertArrayToObject(json['details']);

        return Company.fromJson({...json['company'], ...companyDetails});
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

    final response = await httpAdapter.postApi("orders/v1/editCompany",
        jsonEncode(company.toJson()), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add new company');
    }
  }

  Future<bool> deleteCompany(int companyId) async {
    final response = await httpAdapter.putApi(
        "orders/v1/deleteCompany",
        jsonEncode({
          "id": companyId.toString(),
          "updatedby": DateTime.now().toIso8601String(),
        }),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete company");
    }
  }

  Future<dynamic> getCompanyById(int companyId) async {
    final response = await httpAdapter.getApi("orders/v1/getCompanyById/$companyId", {});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final companyDetails = convertArrayToObject(jsonResponse["company"]['details']);

      final companyData = {...jsonResponse["company"]["company"], ...companyDetails};
      final transformedData = transformKeysToLowercaseAndRemoveSpaces(companyData);
      return transformedData;
    } else {
      throw Exception("Failed to get company");
    }
  }
}


Map<String, dynamic> transformKeysToLowercaseAndRemoveSpaces(Map<dynamic, dynamic> data) {
  final transformedData = <String, dynamic>{};
  
  data.forEach((key, value) {
    final transformedKey = key.toLowerCase().replaceAll(' ', '');
    transformedData[transformedKey] = value;
  });

  return transformedData;
}

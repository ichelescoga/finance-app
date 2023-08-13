import 'dart:convert';
import 'package:developer_company/data/models/company_model.dart';

import 'package:developer_company/shared/utils/http_adapter.dart';

class CompanyProvider {
  final httpAdapter = HttpAdapter();


  Future<List<Company>> fetchCompanies() async {

    final response = await httpAdapter.getApi("orders/v1/empresas", {});
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      
      return jsonResponse.map((json) => Company.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch companies');
    }
  }
}

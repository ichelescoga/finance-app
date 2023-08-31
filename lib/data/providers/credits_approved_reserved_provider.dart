import 'dart:convert';
import 'package:developer_company/data/models/credits_approved_reserved_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class CreditsApprovedReservedProvider {
  final httpAdapter = HttpAdapter();


  Future<List<CreditsApprovedReserved>> fetchCreditsApprovedReserved() async {

    final response = await httpAdapter.getApi("orders/v1/cotizacionEjeAprovReser", {});
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      
      return jsonResponse.map((json) => CreditsApprovedReserved.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch credits approved reserved');
    }
  }
}

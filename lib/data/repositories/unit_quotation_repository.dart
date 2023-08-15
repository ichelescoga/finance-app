import 'package:developer_company/data/models/unit_quotation_model.dart';


abstract class UnitQuotationRepository {
  Future<List<UnitQuotation>> fetchUnitQuotationsForQuotation(int quotationId);
  Future<Quotation?> fetchQuotationById(String quotationId);
}
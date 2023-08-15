import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';

class UnitQuotationRepositoryImpl implements UnitQuotationRepository {
  final UnitQuotationProvider unitQuotationProvider;

  UnitQuotationRepositoryImpl(this.unitQuotationProvider);

  @override
  Future<List<UnitQuotation>> fetchUnitQuotationsForQuotation(int quotationId) async {
    return await unitQuotationProvider.fetchUnitQuotationsForQuotation(quotationId);
  }

  @override
  Future<Quotation?> fetchQuotationById(String quoteId) async {
    return await unitQuotationProvider.fetchQuotationById(quoteId);
  }
}
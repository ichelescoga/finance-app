import 'package:developer_company/data/models/sell_models.dart';
import 'package:developer_company/data/providers/sell_provider.dart';
import 'package:developer_company/data/repositories/sell_repository.dart';

class SellRepositoryImpl implements SellRepository {
  final SellProvider sellProvider;

  SellRepositoryImpl(this.sellProvider);

  @override
  Future<MonetaryDownPayment> getMonetaryDownPayment(String unitId) async {
    return this.sellProvider.getMonetaryDownPayment(unitId);
  }

  @override
  Future<BookModel> getBookModel(String unitId) async {
    return this.sellProvider.getBookModel(unitId);
  }


  @override
  Future<bool> postMonetaryDownPayment(String unitId) async {
    return this.sellProvider.postMonetaryDownPayment(unitId);
  }

  @override
  Future<bool> postBookModel(String unitId) async {
    return this.sellProvider.postBookModel(unitId);
  }

  @override
  Future<bool> postMonetaryFee(String unitId, String interestRate) async {
    return this.sellProvider.postMonetaryFee(unitId, interestRate);
  }

  @override
  Future<StatusOfPayments> getStatusOfPayments(String quoteId) async {
    return this.sellProvider.getStatusOfPayments(quoteId);
  }
}

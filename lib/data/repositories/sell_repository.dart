// import 'package:developer_company/data/models/project_model.dart';

import 'package:developer_company/data/models/sell_models.dart';

abstract class SellRepository {
  Future<StatusOfPayments> getStatusOfPayments(String quoteId);
  Future<MonetaryDownPayment> getMonetaryDownPayment(String unitId);
  Future<BookModel> getBookModel(String unitId);
  Future<bool> postMonetaryDownPayment(String unitId);
  Future<bool> postBookModel(String unitId);
  Future<bool> postMonetaryFee(String unitId, String interestRate);
}

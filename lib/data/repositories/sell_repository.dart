// import 'package:developer_company/data/models/project_model.dart';

import 'package:developer_company/data/models/sell_models.dart';

abstract class SellRepository {
  Future<MonetaryDownPayment> getMonetaryDownPayment(String unitId);
  Future<BookModel> getBookModel(String unitId);
  Future<PayTotalUnitModel> getPayTotalUnit(String unitId);
  Future<bool> postMonetaryDownPayment(String unitId);
  Future<bool> postBookModel(String unitId);
  Future<bool> postPayTotalUnit(String unitId);
  Future<StatusOfPayments> getStatusOfPayments(String quoteId);
}

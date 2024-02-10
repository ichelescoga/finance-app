import 'package:developer_company/data/models/sell_models.dart';
import 'package:developer_company/data/providers/sell_provider.dart';
import 'package:developer_company/data/repositories/sell_repository.dart';

class SellRepositoryImpl implements SellRepository {
  final SellProvider sellProvider;

  SellRepositoryImpl(this.sellProvider);

  @override
  Future<MonetaryDownPayment> getMonetaryDownPayment(int unitId) async {
    return getMonetaryDownPayment(unitId);
  }

  @override
  Future<BookModel> getBookModel(String unitId) async {
    return getBookModel(unitId);
  }

  @override
  Future<PayTotalUnitModel> getPayTotalUnit(String unitId) async {
    return getPayTotalUnit(unitId);
  }

  @override
  Future<bool> postMonetaryDownPayment(DateTime initialDate, DateTime finalDate,
      String projectId, String percentage) async {
    return postMonetaryDownPayment(
        initialDate, finalDate, projectId, percentage);
  }

  @override
  Future<bool> postBookModel(String unitId) async {
    return postBookModel(unitId);
  }

  @override
  Future<bool> postPayTotalUnit(String unitId) async {
    return postPayTotalUnit(unitId);
  }
}

// import 'package:developer_company/data/models/project_model.dart';

import 'package:developer_company/data/models/sell_models.dart';

abstract class ProjectRepository {
  Future<MonetaryDownPayment> getMonetaryDownPayment(int unitId);
  Future<BookModel> getBookModel(String unitId);
  Future<PayTotalUnitModel> getPayTotalUnit(String unitId);
  Future<bool> postMonetaryDownPayment(DateTime initialDate, DateTime finalDate,String projectId, String percentage);
  Future<bool> postBookModel(String unitId);
  Future<bool> postPayTotalUnit(String unitId);
}

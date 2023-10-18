import 'package:developer_company/data/models/discount_model.dart';

abstract class DiscountRepository {
  Future<DiscountSeason> getSeasonDiscount(String projectId);
}

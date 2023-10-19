import 'package:developer_company/data/models/discount_model.dart';

abstract class DiscountRepository {
  Future<DiscountSeason> getSeasonDiscount(String projectId);
  Future<List<RequestedDiscount>> getRequestDiscounts(String projectId);
  Future<bool> acceptDiscount(String discountId);
  Future<bool> rejectDiscount(String discountId);
  Future<List<RequestedDiscount>> getDiscountByResolution(
      bool isApproved, String projectId);
}

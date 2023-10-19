import 'package:developer_company/data/models/discount_model.dart';
import 'package:developer_company/data/providers/discount_provider.dart';
import 'package:developer_company/data/repositories/discount_repository.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountProvider discountProvider;

  DiscountRepositoryImpl(this.discountProvider);

  @override
  Future<DiscountSeason> getSeasonDiscount(String projectId) async {
    return await discountProvider.getSeasonDiscount(projectId);
  }

  @override
  Future<List<RequestedDiscount>> getRequestDiscounts(String projectId) async {
    return await discountProvider.getRequestDiscounts(projectId);
  }
}

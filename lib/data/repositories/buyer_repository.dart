import 'package:developer_company/data/models/buyer_model.dart';

abstract class BuyerRepository {
  Future<String?> postSellBuyerData(BuyerData buyer, String quoteId);
}

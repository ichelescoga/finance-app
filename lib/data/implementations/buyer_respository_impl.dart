import 'package:developer_company/data/models/buyer_model.dart';
import 'package:developer_company/data/providers/buyer_provider.dart';
import 'package:developer_company/data/repositories/buyer_repository.dart';

class BuyerRepositoryImpl implements BuyerRepository {
  final BuyerProvider buyerProvider;

  BuyerRepositoryImpl(this.buyerProvider);

  @override
  Future<String?> postSellBuyerData(BuyerData buyer, String quoteId) async {
    return await this.buyerProvider.postSellBuyerData(buyer, quoteId);
  }
}

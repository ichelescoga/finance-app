import 'package:developer_company/data/models/pre_sell_model.dart';
import 'package:developer_company/data/providers/pre_sell_provider.dart';
import 'package:developer_company/data/repositories/pre_sell_respository.dart';

class PreSellRepositoryImpl implements PreSellRepository {
  final PreSellProvider preSellProvider;

  PreSellRepositoryImpl(this.preSellProvider);

  @override
  Future<PreSell> getInfoClientPreSell(String quoteId) async {
    return await preSellProvider.getInfoClientPreSell(quoteId);
  }
}

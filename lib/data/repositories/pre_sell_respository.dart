
import 'package:developer_company/data/models/pre_sell_model.dart';

abstract class PreSellRepository {
  Future<PreSell> getInfoClientPreSell(String quoteId);
}
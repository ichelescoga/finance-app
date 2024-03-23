import 'package:developer_company/client_rest_api/models/payments/client_payment_model.dart';

class ClientUnitsModel {
  final int unitId;
  final String name;
  final String sellPrice;
  final List<ClientPaymentModel> payments;
  final String quoteId;

  ClientUnitsModel({
    required this.unitId,
    required this.name,
    required this.sellPrice,
    required this.payments,
    required this.quoteId,
  });

  factory ClientUnitsModel.fromJson(json) {
    return ClientUnitsModel(
      unitId: json["unitId"],
      name: json["name"],
      sellPrice: json["sellPrice"],
      quoteId: json["quoteId"].toString(),
      payments: (json["payments"] as List<dynamic>)
          .map((e) => ClientPaymentModel.fromJson(e))
          .toList(),
    );
  }
}

class BankModel {
  final String id;
  final String name;

  BankModel({
    required this.id,
    required this.name,
  });

  factory BankModel.fromJson(json) {
    return BankModel(
      id: json["id"].toString(),
      name: json["name"],
    );
  }
}

class PaymentTypeModel {
  final String id;
  final String name;

  PaymentTypeModel({
    required this.id,
    required this.name,
  });

  factory PaymentTypeModel.fromJson(json) {
    return PaymentTypeModel(
      id: json["id"].toString(),
      name: json["name"],
    );
  }
}

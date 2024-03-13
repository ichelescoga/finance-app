class ClientUnitsModel {
  final int unitId;
  final String name;
  final String sellPrice;

  ClientUnitsModel({
    required this.unitId,
    required this.name,
    required this.sellPrice,
  });

  factory ClientUnitsModel.fromJson(json) {
    return ClientUnitsModel(
      unitId: json["unitId"],
      name: json["name"],
      sellPrice: json["sellPrice"],
    );
  }
}

class DiscountSeason {
  final String discountId;
  final String discountSeasonId;
  final String projectId;
  final String months;
  final int percentage;

  DiscountSeason({
    required this.discountId,
    required this.discountSeasonId,
    required this.projectId,
    required this.months,
    required this.percentage,
  });

  Map<String, dynamic> toJson() {
    return {"discount_data": this.discountId};
  }

  factory DiscountSeason.fromJson(json) {
    return DiscountSeason(
      discountId: json["Id_configuracion_descuento"].toString(),
      discountSeasonId: json["Id_temporada_descuento"].toString(),
      projectId: json["Id_proyecto"].toString(),
      months: json["Meses"],
      percentage:
          int.tryParse(json["Porcentaje"].toString().replaceAll("%", ""))!,
    );
  }
}

class RequestedDiscounts {}

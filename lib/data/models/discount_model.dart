class DiscountSeason {
  final String discountId;

  DiscountSeason({required this.discountId});

  Map<String, dynamic> toJson() {
    return {"discount_data": this.discountId};
  }

  factory DiscountSeason.fromJson(json) {
    return DiscountSeason(discountId: json["discount"]);
  }
}

class DiscountSeasonDetail {
  
}

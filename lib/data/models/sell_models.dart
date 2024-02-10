class BookModel {
  String moneyBook;

  BookModel(
      {required this.moneyBook,
    });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      moneyBook: json["data"].toString(),
    );
  }
}


class MonetaryDownPayment {
  String downPayment;

  MonetaryDownPayment(
      {required this.downPayment,
    });

  factory MonetaryDownPayment.fromJson(Map<String, dynamic> json) {
    return MonetaryDownPayment(
      downPayment: json["data"].toString(),
    );
  }

}


class PayTotalUnitModel {
  String clientId;
  String firstName;

  PayTotalUnitModel(
      {required this.clientId,
      required this.firstName,
    });

  factory PayTotalUnitModel.fromJson(Map<String, dynamic> json) {
    return PayTotalUnitModel(
      clientId: json["Id_cliente_CLIENTE"]["Id_cliente"].toString(),
      firstName: json["Id_cliente_CLIENTE"]["Primer_nombre"],
    );
  }
}



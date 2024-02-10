class BookModel {
  String clientId;
  String firstName;

  BookModel(
      {required this.clientId,
      required this.firstName,
    });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      clientId: json["Id_cliente_CLIENTE"]["Id_cliente"].toString(),
      firstName: json["Id_cliente_CLIENTE"]["Primer_nombre"],
    );
  }
}


class MonetaryDownPayment {
  String clientId;
  String firstName;

  MonetaryDownPayment(
      {required this.clientId,
      required this.firstName,
    });

  factory MonetaryDownPayment.fromJson(Map<String, dynamic> json) {
    return MonetaryDownPayment(
      clientId: json["Id_cliente_CLIENTE"]["Id_cliente"].toString(),
      firstName: json["Id_cliente_CLIENTE"]["Primer_nombre"],
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



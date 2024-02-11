class BookModel {
  String moneyBook;

  BookModel({
    required this.moneyBook,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      moneyBook: json["data"].toString(),
    );
  }
}

class MonetaryDownPayment {
  String downPayment;

  MonetaryDownPayment({
    required this.downPayment,
  });

  factory MonetaryDownPayment.fromJson(Map<String, dynamic> json) {
    return MonetaryDownPayment(
      downPayment: json["data"].toString(),
    );
  }
}

class MonetaryFee {
  String clientId;

  MonetaryFee({
    required this.clientId,
  });

  factory MonetaryFee.fromJson(Map<String, dynamic> json) {
    return MonetaryFee(
      clientId: json["Id_cliente_CLIENTE"]["Id_cliente"].toString(),
    );
  }


}

class StatusOfPayments {
  bool book;
  bool downPayment;
  bool monetaryFee;

  StatusOfPayments({
    required this.book,
    required this.downPayment,
    required this.monetaryFee,
  });

  factory StatusOfPayments.fromJson(Map<String, dynamic> json) {
    return StatusOfPayments(
      book: json["book"],
      downPayment: json["downPayment"],
      monetaryFee: json["totalPayment"],
    );
  }
}



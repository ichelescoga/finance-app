class ClientPaymentModel {
  final int paymentId;
  final int paymentFlowId;
  final String interest;
  final String lastPaymentDate;
  final String lateAmount;
  final String type;
  final String status;
  final String amount;
  final dynamic reference;

  ClientPaymentModel({
    required this.paymentId,
    required this.paymentFlowId,
    required this.interest,
    required this.lastPaymentDate,
    required this.lateAmount,
    required this.type,
    required this.status,
    required this.amount,
    required this.reference,
  });

  factory ClientPaymentModel.fromJson(json) {
    return ClientPaymentModel(
      paymentId: json["paymentId"],
      paymentFlowId: json["paymentFlowId"],
      interest: json["interest"],
      lastPaymentDate: json["lastPaymentDate"],
      lateAmount: json["lateAmount"],
      type: json["type"],
      status: json["status"],
      amount: json["amount"],
      reference: json["reference"],
    );
  }
}

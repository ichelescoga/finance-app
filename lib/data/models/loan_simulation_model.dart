class LoanSimulationRequest {
  final double annualInterest;
  final double annualPayments;
  final double totalCreditValue;
  final double cashPrice;

  LoanSimulationRequest({
    required this.annualInterest,
    required this.annualPayments,
    required this.totalCreditValue,
    required this.cashPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "annualInterest": annualInterest,
      "annualPayments": annualPayments,
      "totalCreditValue": totalCreditValue,
      "cash_price": cashPrice,
    };
  }
}

class LoanSimulationResponse {
  final int iteration;
  final String month;
  final double monthlyInterest;
  final double monthlyCapitalPayment;
  final double monthlyTotalPayment;
  final double creditTotalBalance;

  LoanSimulationResponse({
    required this.iteration,
    required this.month,
    required this.monthlyInterest,
    required this.monthlyCapitalPayment,
    required this.monthlyTotalPayment,
    required this.creditTotalBalance,
  });

  factory LoanSimulationResponse.fromJson(Map<String, dynamic> json) {
    return LoanSimulationResponse(
      iteration: json['iteration'],
      month: json['month'],
      monthlyInterest: json['monthlyInterest'],
      monthlyCapitalPayment: json['monthlyCapitalPayment'],
      monthlyTotalPayment: json['monthlyTotalPayment'],
      creditTotalBalance: json['creditTotalBalance'],
    );
  }
}

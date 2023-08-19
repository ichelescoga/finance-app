class LoanSimulationRequest {
  final dynamic annualInterest;
  final dynamic annualPayments;
  final dynamic totalCreditValue;

  LoanSimulationRequest({
    required this.annualInterest,
    required this.annualPayments,
    required this.totalCreditValue,
  });

  Map<String, dynamic> toJson() {
    return {
      "annualInterest": annualInterest,
      "annualPayments": annualPayments,
      "totalCreditValue": totalCreditValue,
      "cash_price": 1
    };
  }
}

class LoanSimulationResponse {
  final int iteration;
  final String month;
  final dynamic monthlyInterest;
  final dynamic monthlyCapitalPayment;
  final dynamic monthlyTotalPayment;
  final dynamic creditTotalBalance;

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
      month: json['month'].toString(),
      monthlyInterest: json['monthlyInterest'],
      monthlyCapitalPayment: json['monthlyCapitalPayment'],
      monthlyTotalPayment: json['monthlyTotalPayment'],
      creditTotalBalance: json['creditTotalBalance'],
    );
  }
}

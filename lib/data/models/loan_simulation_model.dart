import 'package:developer_company/shared/services/quetzales_currency.dart';

class LoanSimulationRequest {
  final dynamic annualInterest;
  final dynamic annualPayments;
  final dynamic totalCreditValue;
  final bool cashPrice;
  LoanSimulationRequest({
    required this.annualInterest,
    required this.annualPayments,
    required this.totalCreditValue,
    required this.cashPrice
  });

  Map<String, dynamic> toJson() {
    return {
      "annualInterest": annualInterest,
      "annualPayments": annualPayments,
      "totalCreditValue": totalCreditValue,
      "precioContado": cashPrice
    };
  }
}

class LoanSimulationResponse {
  final int iteration;
  final String month;
  final dynamic monthlyInterest;
  final String monthlyCapitalPayment;
  final String monthlyTotalPayment;
  final String creditTotalBalance;

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
      monthlyCapitalPayment: quetzalesCurrency(json['monthlyCapitalPayment'].toString()) ,
      monthlyTotalPayment: quetzalesCurrency(json['monthlyTotalPayment'].toString()),
      creditTotalBalance: quetzalesCurrency(json['creditTotalBalance'].toString()),
    );
  }
}

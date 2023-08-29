import 'package:intl/intl.dart';
import 'dart:core';

String quetzalesCurrency(String value) {
  try {
    String numberToCurrency = value;
    if (numberToCurrency.contains("Q") || numberToCurrency.contains(",")) {
      numberToCurrency = extractNumber(numberToCurrency)!;
    }

    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: "Q ");
    return currencyFormat.format(double.parse(numberToCurrency)).toString();
  } catch (e) {
    return value;
  }
}

String parseCurrency(String value) {
  try {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: 'Q ');
    return currencyFormat.parse(value).toString();
  } catch (e) {
    return value;
  }
}


String? extractNumber(String input) {
  RegExp regex = RegExp(r'[\d.,]+');
  String? match = regex.stringMatch(input);

  if (match != null) {
    match = match.replaceAll(RegExp(r'[^\d.]'), '');
    return match;
  }

  return null;
}
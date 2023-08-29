import 'package:developer_company/shared/services/quetzales_currency.dart';

String handleBalanceToFinance(String sellPrice, String initialPayment) {
  try {
    String sellPriceNumber = sellPrice;
    if (sellPriceNumber.contains("Q")) {
      sellPriceNumber = parseCurrency(sellPrice);
    }

    String startMoneyNumber = initialPayment;
    if (startMoneyNumber.contains("Q") || startMoneyNumber.contains(",")) {
      startMoneyNumber = extractNumber(initialPayment)!;
    }

    double finalSellPrice = double.parse(sellPriceNumber);
    double startMoney = double.parse(startMoneyNumber);
    return quetzalesCurrency((finalSellPrice - startMoney).toString());
  } catch (e) {
    return quetzalesCurrency(sellPrice);
  }
}

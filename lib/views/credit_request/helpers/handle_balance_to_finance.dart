String handleBalanceToFinance(String sellPrice, String initialPayment) {
  try {
    double finalSellPrice = double.parse(sellPrice);
    double startMoney = double.parse(initialPayment);
    return (finalSellPrice - startMoney).toString();
  } catch (e) {
    return sellPrice;
  }
}

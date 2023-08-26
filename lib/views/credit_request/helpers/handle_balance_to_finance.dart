import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';

void handleBalanceToFinance() {
  UnitDetailPageController unitDetailPageController =
      UnitDetailPageController();
  try {
    double finalSellPrice =
        double.parse(unitDetailPageController.finalSellPrice.text);
    double startMoney = double.parse(unitDetailPageController.startMoney.text);

    unitDetailPageController.balanceToFinance.text =
        (finalSellPrice - startMoney).toString();
  } catch (e) {
    unitDetailPageController.balanceToFinance.text =
        unitDetailPageController.finalSellPrice.text;
  }
}

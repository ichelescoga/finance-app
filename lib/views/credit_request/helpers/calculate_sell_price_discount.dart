import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/validations/percentage_validator.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String calculateSellPriceDiscount(
    value, UnitDetailPageController controller, String salePriceString) {
  if (value == null) {
    return controller.finalSellPrice.text = controller.salePrice.text;
  }
  final salePrice = double.tryParse(salePriceString);
  final discountPercentage = int.tryParse(value);
  if (discountPercentage != null && !percentageValidator(value)) {
    EasyLoading.showInfo("El Descuento máximo es de 25%, descuento no aplicado");
    return quetzalesCurrency(salePrice.toString());
  } else if (salePrice != null && discountPercentage != null) {
    final discountAmount = salePrice * (discountPercentage / 100);
    return quetzalesCurrency((salePrice - discountAmount).toString());
  } else {
    return quetzalesCurrency(salePrice.toString());
  }
}

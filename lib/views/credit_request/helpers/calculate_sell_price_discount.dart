
  import 'package:developer_company/shared/validations/percentage_validator.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';

String calculateSellPriceDiscount(value, UnitDetailPageController controller, String salePriceString) {
    if (value == null) {
      return controller.finalSellPrice.text =
          controller.salePrice.text;
    }
    final salePrice = double.tryParse(salePriceString);
    final discountPercentage = int.tryParse(value);
    if (discountPercentage != null && !percentageValidator(value)) {
      return salePrice.toString();
    } else if (salePrice != null && discountPercentage != null) {
      final discountAmount = salePrice * (discountPercentage / 100);
      return (salePrice - discountAmount).toString();
    } else {
      return salePrice.toString();
    }
  }
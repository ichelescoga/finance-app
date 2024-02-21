import 'package:developer_company/shared/controllers/base_controller.dart';

class CDICheckController extends BaseController {
  bool isChecked = false;

  int convertValueToInt(bool value) {
    return value ? 1 : 0;
  }
}

import 'package:developer_company/shared/resources/strings.dart';

dynamic notEmptyFieldValidator(String? value) {
  if (value!.isEmpty) {
    return Strings.pleaseFillOutTheField;
  } else {
    return null;
  }
}

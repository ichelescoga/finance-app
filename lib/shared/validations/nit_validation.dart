import 'package:developer_company/shared/resources/strings.dart';

dynamic nitValidation(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return Strings.pleaseFillOutTheField;
  } else if (value.length <= 6) {
    return Strings.nitShouldBeGraterThan6;
  } else {
    return null;
  }
}

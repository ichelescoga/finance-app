import 'package:easy_stepper/easy_stepper.dart';

TextInputType getKeyboardTypeFromString(String keyboardKey) {
  switch (keyboardKey) {
    case "String":
      return TextInputType.text;
    case "Phone":
      return TextInputType.phone;
    case "Integer":
      return TextInputType.number;
    case "Date":
      return TextInputType.datetime;
    default:
      return TextInputType.text;
  }
}

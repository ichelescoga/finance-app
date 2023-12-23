import 'package:developer_company/shared/validations/string_length_validator.dart';
import "package:developer_company/shared/resources/strings.dart";

dynamic phone_validator(String? value) => stringLengthValidator(value, 8, 8)
    ? null
    : '${Strings.numberPhoneNotValid}, dígitos ${value?.length}';

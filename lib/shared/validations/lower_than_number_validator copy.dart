bool lowerThanNumberValidator(String? value, double number) {
  try {
    if (value == null) return false;
    return double.parse(value) <= number;
  } catch (e) {
    return false;
  }
}

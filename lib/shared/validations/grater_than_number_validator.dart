bool graterThanNumberValidator(String? value, int number) {
  try {
    if (value == null) return false;
    return double.parse(value) >= number;
  } catch (e) {
    return false;
  }
}

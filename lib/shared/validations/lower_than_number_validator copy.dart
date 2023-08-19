bool lowerThanNumberValidator(String? value, int number) {
  try {
    if (value == null) return false;
    return int.parse(value) <= number;
  } catch (e) {
    return false;
  }
}

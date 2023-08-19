bool stringLengthValidator(String? value, int min, int max) {
  if (value == null) return false;
  try {
    int number = value.length;
    return number >= min && number <= max;
  } catch (e) {
    return false;
  }
}

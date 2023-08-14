bool percentageValidator(String? value) {
  if (value == null) return false;

  final percentageValue = int.tryParse(value);
  if (percentageValue! < 1 || percentageValue > 100) {
    return false;
  }
  return true;
}

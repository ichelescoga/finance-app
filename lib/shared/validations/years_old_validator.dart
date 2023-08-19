bool yearsOldValidator(String? value, int yearsOld) {
  if (value == null) return false;

  DateTime currentDate = DateTime.now();
  DateTime birthDate = DateTime.parse(value);
  Duration difference = currentDate.difference(birthDate);

  int years = difference.inDays ~/ 365;

  return years >= yearsOld;
  
}

bool daysOldValidator(String? value, int daysOld) {
  if (value == null) return false;

  DateTime currentDate = DateTime.now();
  DateTime birthDate = DateTime.parse(value);
  Duration difference = currentDate.difference(birthDate);

  int days = difference.inDays;

  return days >= daysOld;
}
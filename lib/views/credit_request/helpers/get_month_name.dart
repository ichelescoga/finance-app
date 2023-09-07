String getMonthSpanishName(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr);
  return getMonthName(dateTime.month);
}

String getMonthName(int monthNumber) {
  final Map<int, String> monthNames = {
    1: 'Enero',
    2: 'Febrero',
    3: 'Marzo',
    4: 'Abril',
    5: 'Mayo',
    6: 'Junio',
    7: 'Julio',
    8: 'Agosto',
    9: 'Septiembre',
    10: 'Octubre',
    11: 'Noviembre',
    12: 'Diciembre',
  };

  return monthNames[monthNumber] ?? 'Unknown'; // Default to 'Unknown' if the month number is not valid
}

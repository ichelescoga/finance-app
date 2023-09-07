String getYearName(String date) {
  DateTime dateTime = DateTime.parse(date);
  final int year = dateTime.year;
  if (year < 1000 || year > 9999) {
    throw ArgumentError('The year must be between 1000 and 9999.');
  }

  final List<String> units = [
    '', 'un', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve'
  ];

  final List<String> tens = [
    '', '', 'veinte', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa'
  ];

  final String lastTwoDigits = (year % 100).toString().padLeft(2, '0');
  final int tensDigit = int.parse(lastTwoDigits[0]);
  final int unitsDigit = int.parse(lastTwoDigits[1]);

  if (tensDigit == 0) {
    return units[unitsDigit];
  } else if (tensDigit == 1) {
    if (unitsDigit == 0) {
      return 'diez';
    } else if (unitsDigit == 1) {
      return 'once';
    } else if (unitsDigit == 2) {
      return 'doce';
    } else if (unitsDigit == 3) {
      return 'trece';
    } else if (unitsDigit == 4) {
      return 'catorce';
    } else if (unitsDigit == 5) {
      return 'quince';
    } else {
      return 'dieci' + units[unitsDigit];
    }
  } else if (tensDigit == 2) {
    return 'veinti' + units[unitsDigit];
  } else {
    return tens[tensDigit] + (unitsDigit != 0 ? 'i' + units[unitsDigit] : '');
  }
}
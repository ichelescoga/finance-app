dynamic isPasswordValid(String? value) {
  if (value == null) {
    return "Contraseña no valida.";
  }
  if (value.isEmpty) {
    return 'Contraseña no puede estar vacía';
  }
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$');
  if (!passwordRegex.hasMatch(value)) {
    return 'patron de seguridad invalido.';
  }
  return null;
}

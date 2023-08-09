dynamic emailValidator(String? value) {
  if (value == null) {
    return "Email es obligatorio.";
  }
  if (value.isEmpty) {
    return 'Este campo es obligatorio.';
  }
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Email no válido.';
  }
  return null;
}

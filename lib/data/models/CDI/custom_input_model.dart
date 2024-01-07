class QTS_input {
  final String type;
  final String label;
  final String placeholder;
  final String inputType;
  final String icon;
  final String hintText;

  QTS_input({
    required this.type,
    required this.label,
    required this.placeholder,
    required this.inputType,
    required this.icon,
    required this.hintText,
  });

  factory QTS_input.fromJson(Map<String, dynamic> json) {
    return QTS_input(
      type: json['type'],
      label: json['label'] ?? "",
      placeholder: json['placeholder'] ?? "",
      inputType: json['inputType'] ?? "",
      icon: json['icon'] ?? "",
      hintText: json['hintText'] ?? "",
    );
  }
}
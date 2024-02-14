class QTS_dropdown {
  final String type;
  final String label;
  final String placeholder;
  final String inputType;
  final String hintText;
  final Map<String, String>? items;

  QTS_dropdown({
    required this.type,
    required this.label,
    required this.placeholder,
    required this.inputType,
    required this.hintText,
    this.items,
  });

  factory QTS_dropdown.fromJson(Map<String, dynamic> json) {
    return QTS_dropdown(
      type: json['type'],
      label: json['label'] ?? "",
      placeholder: json['placeholder'] ?? "",
      inputType: json['inputType'] ?? "",
      hintText: json['hintText'] ?? "",
      items: json['items'] != null
          ? {
              'url': json['items']['url'],
              'key': json['items']['key'] ?? "",
              'value': json['items']['value'] ?? "",
            }
          : null,
    );
  }
}
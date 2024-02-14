class QTS_image {
  final String type;
  final String placeholder;
  final Map<String, String>? items;

  QTS_image({required this.type, required this.placeholder, this.items});

  factory QTS_image.fromJson(Map<String, dynamic> json) {
    return QTS_image(
      type: json['type'],
      placeholder: json['placeholder'] ?? "",
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
class QTS_Table {
  final String type;
  final String hintText;
  final Map<String, String>? items;

  QTS_Table({required this.type, required this.hintText, this.items});

  factory QTS_Table.fromJson(Map<String, dynamic> json) {
    return QTS_Table(
      type: json['type'],
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
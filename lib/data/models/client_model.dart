class Client {
  final String? name;
  final String? phone;
  final String? email;

  Client({
    required this.name,
    required this.phone,
    required this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['Primer_nombre'],
      phone: json['Telefono'],
      email: json['Correo'],
    );
  }
}
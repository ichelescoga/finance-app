class ClientModel {
  final String? name;
  final String? phone;
  final String? email;
  final int id;

  ClientModel({
    required this.name,
    required this.phone,
    required this.email,
    this.id = 0,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      name: json['Primer_nombre'],
      phone: json['Telefono'],
      email: json['Correo'],
      id: json['Id_cliente']!
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "primerNombre": this.name,
      "correo": this.email,
      "telefono": this.phone,
      "idNacionalidad": 1
    };
  }
}

class QuickClientContacts {
  final int projectId;
  final int? contactId;
  final bool state;
  final String fullName;
  final String phone;
  final String email;
  final String address;

  QuickClientContacts({
    this.contactId,
    required this.projectId,
    required this.state,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "idProyecto": projectId,
      "state": state ? "1" : "0",
      "nombreCompleto": fullName,
      "telefono": phone,
      "correo": email,
      "direccion": address
    };
  }

  factory QuickClientContacts.fromJson(Map<String, dynamic> json) {
    return QuickClientContacts(
        projectId: json["Id_proyecto"],
        contactId: json["Id_contacto"],
        state: json["state"].toString() == "1" ? true : false,
        fullName: json["Nombre_completo"],
        phone: json["Telefono"],
        email: json["Correo"],
        address: json["Direccion"]);
  }
}

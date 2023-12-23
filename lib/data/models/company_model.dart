class Company {
  int? companyId;
  final String businessName;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool state;
  final String developer;
  final String nit;
  final String address;
  final String contact;
  final String contactPhone;
  final String salesManager;
  final String managerPhone;
  final String logo;

  Company({
    this.companyId,
    required this.businessName,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.state = false,
    required this.developer,
    required this.nit,
    required this.address,
    required this.contact,
    required this.contactPhone,
    required this.salesManager,
    required this.managerPhone,
    required this.logo,
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': companyId,
      'nombre': businessName,
      'descripcion': description,
      'createdby': createdAt.toIso8601String(),
      "updatedby": updatedAt.toIso8601String(),
      'desarrollador': developer,
      'nit': nit,
      'direccion': address,
      'contacto': contact,
      'telefonocontacto': contactPhone,
      'gerenteventas': salesManager,
      'telefonogerenteventas': managerPhone,
      'logo': logo,
    };
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['Id'],
      businessName: json['Nombre'],
      description: json['Descripcion'],
      createdAt: DateTime.parse(json['Created_at']),
      updatedAt: DateTime.parse(json['Updated_at']),
      state: json['Estado'],
      developer: json['Desarrollador'],
      nit: json['NIT'],
      address: json['Direccion'],
      contact: json['Contacto'],
      contactPhone: json['Telefono Contacto'],
      salesManager: json['Gerente de Ventas'],
      managerPhone: json['Telefono Gerente'],
      logo: json['Logo'],
    );
  }
}

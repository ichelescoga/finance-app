class Company {
  final int companyId;
  final String businessName;
  final String comercialName;
  final String legalRepresentative;
  final String nit;
  final String dpi;
  final String address;
  final String postalCode;
  final String phone;
  final String contactName;
  final String contactPhone;
  final String salesManager;
  final String salesManagerPhone;
  final int countryId;
  final int departmentId;
  final int municipalityId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Company({
    required this.companyId,
    required this.businessName,
    required this.comercialName,
    required this.legalRepresentative,
    required this.nit,
    required this.dpi,
    required this.address,
    required this.postalCode,
    required this.phone,
    required this.contactName,
    required this.contactPhone,
    required this.salesManager,
    required this.salesManagerPhone,
    required this.countryId,
    required this.departmentId,
    required this.municipalityId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['Id_empresa'],
      businessName: json['Razon_social'],
      comercialName: json['Nombre_comercial'],
      legalRepresentative: json['Representante_legal'],
      nit: json['NIT'],
      dpi: json['DPI'],
      address: json['Direccion'],
      postalCode: json['Codigo_postal'],
      phone: json['Telefono'],
      contactName: json['Nombre_contacto'],
      contactPhone: json['Telefono_contacto'],
      salesManager: json['Gerente_ventas'],
      salesManagerPhone: json['Telefono_gerente'],
      countryId: json['Id_pais'],
      departmentId: json['Id_departamento'],
      municipalityId: json['Id_municipio'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
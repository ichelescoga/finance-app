class PreSell {
  String clientId;
  String firstName;
  String birthDate;
  String occupation;
  String phoneNumber;
  String email;
  String nationalityId;
  String position;
  String frontDpiPhoto;
  String reverseDpiPhoto;
  String fatherNationalityId;
  String phoneAreaCode;
  String quotationUnitId;
  String quotationId;
  String unitId;
  String unitStatusId;
  String unitUnitId;
  String unitName;
  String salePrice;

  PreSell(
      {required this.clientId,
      required this.firstName,
      required this.birthDate,
      required this.occupation,
      required this.phoneNumber,
      required this.email,
      required this.unitStatusId,
      required this.nationalityId,
      required this.position,
      required this.frontDpiPhoto,
      required this.reverseDpiPhoto,
      required this.fatherNationalityId,
      required this.phoneAreaCode,
      required this.quotationUnitId,
      required this.quotationId,
      required this.unitId,
      required this.unitUnitId,
      required this.unitName,
      required this.salePrice});

  factory PreSell.fromJson(Map<String, dynamic> json) {
    return PreSell(
      clientId: json["Id_cliente_CLIENTE"]["Id_cliente"].toString(),
      firstName: json["Id_cliente_CLIENTE"]["Primer_nombre"],
      birthDate: json["Id_cliente_CLIENTE"]["Fecha_nacimiento"],
      occupation: json["Id_cliente_CLIENTE"]["Puesto"],
      phoneNumber: json["Id_cliente_CLIENTE"]["Telefono"],
      email: json["Id_cliente_CLIENTE"]["Correo"],
      nationalityId: json["Id_cliente_CLIENTE"]["Id_nacionalidad"].toString(),
      position: json["Id_cliente_CLIENTE"]["Puesto"],
      frontDpiPhoto: json["Id_cliente_CLIENTE"]["Foto_DPI_enfrente"],
      reverseDpiPhoto: json["Id_cliente_CLIENTE"]["Foto_DPI_reverso"],
      fatherNationalityId: json["Id_cliente_CLIENTE"]["Id_nacionalidad_PAI"]
          ["Nombre_pais"],
      phoneAreaCode: json["Id_cliente_CLIENTE"]["Id_nacionalidad_PAI"]
          ["Telefono_codigo"],
      quotationUnitId:
          json["UNIDAD_COTIZACIONs"][0]["Id_unidad_cotizacion"].toString(),
      quotationId: json["UNIDAD_COTIZACIONs"][0]["Id_cotizacion"].toString(),
      unitId: json["UNIDAD_COTIZACIONs"][0]["Id_unidad"].toString(),
      unitUnitId: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Id_unidad"]
          .toString(),
      unitStatusId: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Id_estado"]
          .toString(),
      unitName: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]
          ["Nombre_unidad"],
      salePrice: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]
          ["Precio_Venta"],
    );
  }
}

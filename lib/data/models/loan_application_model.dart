class LoanApplication {
  final String? idAplicacion;
  final String idCotizacion;
  final int? idCliente;
  final String fotoDpiEnfrente;
  final String fotoDpiReverso;
  final int estado;
  final int? idDetalleFiador;
  final String empresa;
  final String sueldo;
  final String fechaIngreso;
  final String dpi;
  final String nit;

  LoanApplication({
    this.idAplicacion,
    required this.idCotizacion,
    this.idCliente,
    required this.fotoDpiEnfrente,
    required this.fotoDpiReverso,
    required this.estado,
    this.idDetalleFiador,
    required this.empresa,
    required this.sueldo,
    required this.fechaIngreso,
    required this.dpi,
    required this.nit,
  });

  Map<String, dynamic> toJson() {
    return {
      "idCotizacion": idCotizacion,
      "idCliente": idCliente,
      "fotoDpiEnfrente": fotoDpiEnfrente,
      "fotoDpiReverso": fotoDpiReverso,
      "estado": estado,
      "idDetalleFiador": idDetalleFiador,
      "empresa": empresa,
      "sueldo": sueldo,
      "fechaIngreso": fechaIngreso,
      "dpi": dpi,
      "nit": nit,
    };
  }

  factory LoanApplication.fromJson(Map<String, dynamic> json) {
    return LoanApplication(
        idAplicacion: json['Id_aplicacion'].toString(),
        idCotizacion: json['Id_cotizacion'].toString(),
        fotoDpiEnfrente: json['Foto_DPI_enfrente'],
        fotoDpiReverso: json['Foto_DPI_reverso'],
        estado: json['Estado'],
        empresa: json['Empresa'],
        sueldo: double.tryParse(json['Sueldo'])?.toStringAsFixed(2).toString() ?? "0",
        fechaIngreso: json['Fecha_ingreso'],
        dpi: json['DPI'],
        nit: json['NIT']);
  }
}

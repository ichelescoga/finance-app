class LoanApplication {
  final int idCotizacion;
  final int? idCliente;
  final String fotoDpiEnfrente;
  final String fotoDpiReverso;
  final int estado;
  final int? idDetalleFiador;
  final String empresa;
  final double sueldo;
  final String fechaIngreso;
  final int dpi;
  final int nit;

  LoanApplication({
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
        idCotizacion: json['idCotizacion'],
        fotoDpiEnfrente: json['fotoDpiEnfrente'],
        fotoDpiReverso: json['fotoDpiReverso'],
        estado: json['estado'],
        empresa: json['empresa'],
        sueldo: json['sueldo'],
        fechaIngreso: json['fechaIngreso'],
        dpi: json['dpi'],
        nit: json['nit']);
  }

}

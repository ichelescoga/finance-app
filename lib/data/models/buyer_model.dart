class BuyerData {
  String nombreCompletoCmprd;
  String fechaNacimientoCmprd;
  String estadoCivilCmprd;
  String nacionalidadCmprd;
  String profesionCmprd;
  String residenciaCmprd;
  String telefonoCmprd;
  String direccionTrabajoCmprd;
  String telefonoTrabajoCmprd;
  String ingresoMensualTextoCmprd;
  String ingresoMensualNumCmprd;
  String correoElectronicoCmprd;
  String docIdentificacionCmprd;
  String pasaporteCmprd;
  String dpiCmprd;
  String extendido;
  String razonSocial;
  String urlFotocopiaRepresentacion;
  String valorTotalLote;
  String valorMejoras;
  String contado;
  String reserva;
  String fechaLimiteCancelSaldo;
  String enganche;
  String saldo;
  String numeroCuotas;
  String valorCuota;
  String ciudad;
  List<Reference> referencia;

  BuyerData({
    required this.nombreCompletoCmprd,
    required this.fechaNacimientoCmprd,
    required this.estadoCivilCmprd,
    required this.nacionalidadCmprd,
    required this.profesionCmprd,
    required this.residenciaCmprd,
    required this.telefonoCmprd,
    required this.direccionTrabajoCmprd,
    required this.telefonoTrabajoCmprd,
    required this.ingresoMensualTextoCmprd,
    required this.ingresoMensualNumCmprd,
    required this.correoElectronicoCmprd,
    required this.docIdentificacionCmprd,
    required this.pasaporteCmprd,
    required this.dpiCmprd,
    required this.extendido,
    required this.razonSocial,
    required this.urlFotocopiaRepresentacion,
    required this.valorTotalLote,
    required this.valorMejoras,
    required this.contado,
    required this.reserva,
    required this.fechaLimiteCancelSaldo,
    required this.enganche,
    required this.saldo,
    required this.numeroCuotas,
    required this.valorCuota,
    required this.ciudad,
    required this.referencia,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombreCompletoCmprd': nombreCompletoCmprd,
      'fechaNacimientoCmprd': fechaNacimientoCmprd,
      'estadoCivilCmprd': estadoCivilCmprd,
      'nacionalidadCmprd': nacionalidadCmprd,
      'profesionCmprd': profesionCmprd,
      'residenciaCmprd': residenciaCmprd,
      'telefonoCmprd': telefonoCmprd,
      'direccionTrabajoCmprd': direccionTrabajoCmprd,
      'telefonoTrabajoCmprd': telefonoTrabajoCmprd,
      'ingresoMensualTextoCmprd': ingresoMensualTextoCmprd,
      'ingresoMensualNumCmprd': ingresoMensualNumCmprd,
      'correoElectronicoCmprd': correoElectronicoCmprd,
      'docIdentificaionCmprd': docIdentificacionCmprd,
      'pasaporteCmprd': pasaporteCmprd,
      'dpiCmprd': dpiCmprd,
      'extendido': extendido,
      'razonSocial': razonSocial,
      'urlFotocopiaRepresentacion': urlFotocopiaRepresentacion,
      'valorTotalLote': valorTotalLote,
      'valorMejoras': valorMejoras,
      'contado': contado,
      'reserva': reserva,
      'fechaLimiteCancelSaldo': fechaLimiteCancelSaldo,
      'enganche': enganche,
      'saldo': saldo,
      'numeroCuotas': numeroCuotas,
      'valorCuota': valorCuota,
      'ciudad': ciudad,
      'referencia': referencia.map((e) => e.toJson()).toList(),
    };
  }
}

class Reference {
  String nombreCompleto;
  String residencia;
  String telefono;

  Reference({
    required this.nombreCompleto,
    required this.residencia,
    required this.telefono,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombreCompleto': nombreCompleto,
      'residencia': residencia,
      'telefono': telefono,
    };
  }
}

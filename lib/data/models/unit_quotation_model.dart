// models/unit_quotation_model.dart
class Quotation {
  final int quotationId;
  final int detailAdvisorId;
  final int estadoId;
  final int planFinancieroId; // This could be nullable
  final int clientId; // This could be nullable
  final String date;
  final String dateTime;
  final String monthlyIncome;
  final String downPayment;
  final int termMonths;
  final int startMonth;
  final int startYear;
  final int endMonth;
  final int endYear;
  final int discount;
  final String saleDiscount;
  final int cashPrice;
  final int aguinaldo;
  final int bonusCatorce;
  final DateTime createdAt;
  final DateTime updatedAt;

  Quotation({
    required this.quotationId,
    required this.detailAdvisorId,
    required this.estadoId,
    required this.planFinancieroId,
    required this.clientId,
    required this.date,
    required this.dateTime,
    required this.monthlyIncome,
    required this.downPayment,
    required this.termMonths,
    required this.startMonth,
    required this.startYear,
    required this.endMonth,
    required this.endYear,
    required this.discount,
    required this.saleDiscount,
    required this.cashPrice,
    required this.aguinaldo,
    required this.bonusCatorce,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return Quotation(
      quotationId: json['Id_cotizacion'],
      detailAdvisorId: json['Id_detalle_asesor'],
      estadoId: json['Id_estado'],
      planFinancieroId: json['Id_plan_financiero'],
      clientId: json['Id_cliente'],
      date: json['Fecha'],
      dateTime: json['Fecha_hora'],
      monthlyIncome: json['Ingreso_mensual'],
      downPayment: json['Enganche'],
      termMonths: json['Meses_plazo'],
      startMonth: json['Mes_inicio'],
      startYear: json['Anio_inicio'],
      endMonth: json['Mes_fin'],
      endYear: json['Anio_fin'],
      discount: json['Descuento'],
      saleDiscount: json['Venta_descuento'],
      cashPrice: json['Precio_contado'],
      aguinaldo: json['Aguinaldo'],
      bonusCatorce: json['Bono_catorce'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class UnitQuotation {
  final int unitQuotationId;
  final int quotationId;
  final int unitId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Quotation quotation;

  UnitQuotation({
    required this.unitQuotationId,
    required this.quotationId,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
    required this.quotation,
  });

  factory UnitQuotation.fromJson(Map<String, dynamic> json) {
    return UnitQuotation(
      unitQuotationId: json['Id_unidad_cotizacion'],
      quotationId: json['Id_cotizacion'],
      unitId: json['Id_unidad'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      quotation: Quotation.fromJson(json['Id_cotizacion_COTIZACION']),
    );
  }
}

import 'package:developer_company/shared/utils/discount_status_text.dart';

class DiscountSeason {
  final String discountId;
  final String discountSeasonId;
  final String projectId;
  final String months;
  final int percentage;

  DiscountSeason({
    required this.discountId,
    required this.discountSeasonId,
    required this.projectId,
    required this.months,
    required this.percentage,
  });

  Map<String, dynamic> toJson() {
    return {"discount_data": this.discountId};
  }

  factory DiscountSeason.fromJson(json) {
    return DiscountSeason(
      discountId: json["Id_configuracion_descuento"].toString(),
      discountSeasonId: json["Id_temporada_descuento"].toString(),
      projectId: json["Id_proyecto"].toString(),
      months: json["Meses"],
      percentage:
          int.tryParse(json["Porcentaje"].toString().replaceAll("%", ""))!,
    );
  }
}

class RequestedDiscount {
  String clientName;
  String unitName;
  int quotationId;
  int stateId;
  int clientId;
  int termMonths;
  int endMonth;
  int endYear;
  double discountSale;
  bool cashPrice;
  double bonus;
  double fourteenBonus;
  String? comment;
  double extraDiscount;
  int discountRequest;
  String? discountState;

  RequestedDiscount(
      {required this.quotationId,
      required this.stateId,
      required this.clientId,
      required this.termMonths,
      required this.endMonth,
      required this.endYear,
      required this.discountSale,
      required this.cashPrice,
      required this.bonus,
      required this.fourteenBonus,
      required this.comment,
      required this.extraDiscount,
      required this.discountRequest,
      this.discountState,
      required this.clientName,
      required this.unitName});

  factory RequestedDiscount.fromJson(Map<String, dynamic> json) {
    return RequestedDiscount(
      clientName: json["Id_cliente_CLIENTE"]["Primer_nombre"],
      unitName: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]
          ["Nombre_unidad"],
      quotationId: json['Id_cotizacion'],
      stateId: json['Id_estado'],
      clientId: json['Id_cliente'],
      termMonths: json['Meses_plazo'],
      endMonth: json['Mes_fin'],
      endYear: json['Anio_fin'],
      discountSale: double.tryParse(json['Venta_descuento'].toString()) ?? 0,
      cashPrice: json['Precio_contado'].toString() == "1" ? true : false,
      bonus: double.tryParse(json['Aguinaldo'].toString()) ?? 0,
      fourteenBonus: double.tryParse(json['Bono_catorce'].toString()) ?? 0,
      comment: json['Comentario'],
      extraDiscount:
          double.tryParse(json['Monto_descuento_soli'].toString()) ?? 0,
      discountRequest: json['Solicitud_descuento'],
      discountState: getTextStatusDiscount(
          json['Solicitud_descuento'].toString(),
          json['Estado_descuento'].toString(),
          json['Monto_descuento_soli'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_cotizacion': quotationId,
      'Id_estado': stateId,
      'Id_cliente': clientId,
      'Meses_plazo': termMonths,
      'Mes_fin': endMonth,
      'Anio_fin': endYear,
      'Venta_descuento': discountSale.toStringAsFixed(2),
      'Precio_contado': cashPrice,
      'Aguinaldo': bonus.toStringAsFixed(2),
      'Bono_catorce': fourteenBonus.toStringAsFixed(2),
      'Comentario': comment,
      'Monto_descuento_soli': extraDiscount.toStringAsFixed(2),
      'Solicitud_descuento': discountRequest,
      'Estado_descuento': discountState,
      "cliente": clientName,
      "unitName": unitName
    };
  }
}

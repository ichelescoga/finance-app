// models/cotizacion.dart
// import 'package:developer_company/data/models/client_model.dart';

import 'package:developer_company/shared/services/quetzales_currency.dart';

class AnalystQuotation {
  final int id;
  final int unitId;
  final String unitName;
  final int statusId;
  final String sellPrice;
  final String buyPrice;
  final String executive;
  final String clientName;
  // Other properties you need

  AnalystQuotation({
    required this.id,
    required this.unitId,
    required this.unitName,
    required this.statusId,
    required this.sellPrice,
    required this.buyPrice,
    required this.executive,
    required this.clientName,
  });

  factory AnalystQuotation.fromJson(Map<String, dynamic> json) {
    return AnalystQuotation(
      id: json['Id_cotizacion'],
      unitId: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Id_unidad"],
      unitName: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Nombre_unidad"],
      statusId: json['Id_estado'],
      sellPrice:quetzalesCurrency( json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Precio_Venta"].toString()),
      buyPrice: quetzalesCurrency(json['Venta_descuento'].toString()),
      executive: json["Id_detalle_asesor_ASESOR_DETALLE"]["Id_empleado_EMPLEADO_ASESOR"]["Primer_nombre"],
      clientName: json['Id_cliente_CLIENTE'] == null ? "" : json['Id_cliente_CLIENTE']["Primer_nombre"],
      // Initialize other properties from the JSON response
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "unitId": unitId,
      "unitName": unitName,
      "statusId": statusId,
      "sellPrice": sellPrice,
      "buyPrice": buyPrice,
      "executive": executive,
      "clientName": clientName,
    };
  }
}

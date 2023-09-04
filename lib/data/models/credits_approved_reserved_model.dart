import 'package:developer_company/shared/services/quetzales_currency.dart';

class CreditsApprovedReserved {
  final String quoteId;
  final String clientName;
  final String unitName;
  final String unitId;
  final int unitStatusId;
  final String sellPrice;
  final String sellToFinance;
  final int statusId;

  CreditsApprovedReserved(
      {required this.quoteId,
        required this.clientName,
      required this.unitName,
      required this.unitId,
      required this.unitStatusId,
      required this.sellPrice,
      required this.sellToFinance,
      required this.statusId});

  factory CreditsApprovedReserved.fromJson(Map<String, dynamic> json) {
    final unitStatusId = json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Id_estado"];
    final quoteStatusId = json["Id_estado"];

    return CreditsApprovedReserved(
        quoteId: json["Id_cotizacion"].toString(),
        clientName: json["Id_cliente_CLIENTE"]["Primer_nombre"],
        unitName: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Nombre_unidad"],
        unitStatusId: unitStatusId,
        unitId: json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Id_unidad"].toString(),
        sellPrice: quetzalesCurrency(json["UNIDAD_COTIZACIONs"][0]["Id_unidad_UNIDAD"]["Precio_Venta"].toString()),
        sellToFinance: quetzalesCurrency(double.parse(json["Venta_descuento"]).toString()),
        statusId: quoteStatusId
        );
  }
}

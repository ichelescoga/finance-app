// Map<int, String> unitStatus = {
//   1: "Disponible",
//   2: "Inicializada",
//   3: "Cotizada",
//   4: "Vendida"
// };
//! UNIDAD

//! COTIZACION

//! APLICACION DE CREDITO

Map<int, String> unitStatus = {
  1: "Inicializada",
  2: "Cotizada",
  3: "Vendida",
  4: "Disponible",
  5: "Reservada", // cuando este en reserva la unidad ya no estará disponible.
  6: "Rechazada",
  7: "Aprobada",
  9: "Enganchada",
};

String getUnitStatus(int? statusId) {
  String? result = unitStatus[statusId];
  if (result == null) {
    return "Desconocido";
  }
  return result;
}


bool isAvailableForQuote(int? statusId) {
  if(statusId == null) return true;
  if(statusId == 3 || statusId == 5 || statusId == 9) {
    return false;
  }

  return true;
}
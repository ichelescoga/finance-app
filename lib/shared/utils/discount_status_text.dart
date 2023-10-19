String getTextStatusDiscount(
    String? statusDiscount, String? resolutionDiscount, String? extraDiscount) {
  if (statusDiscount == "0" && extraDiscount == null) {
    return "";
  } else if (statusDiscount == "0" && extraDiscount != null) {
    return "Descuento Solicitado";
  } else if (statusDiscount == "1" && resolutionDiscount == "0") {
    return "Descuento Rechazado";
  } else if (statusDiscount == "1" && resolutionDiscount == "0") {
    return "Descuento Aprobado";
  }
  return "Descuento Solicitado";
}

bool isActiveDiscount(String? statusDiscount) {
  return statusDiscount != null;
}

bool isApprovedDiscount(
    String? statusDiscount, String? resolutionDiscount) {

  if (statusDiscount == "1" && resolutionDiscount == "0") {
    return false;
  } else if (statusDiscount == "1" && resolutionDiscount == "0") {
    return true;
  }
  return false;
}

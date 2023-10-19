String getTextStatusDiscount(
    String? statusDiscount, String? resolutionDiscount, String? extraDiscount) {
  if (statusDiscount == "0" && extraDiscount == null) {
    return "";
  } else if (statusDiscount == "0" && extraDiscount != null) {
    return "descuento Solicitado";
  } else if (statusDiscount == "1" && resolutionDiscount == "0") {
    return "descuento Rechazado";
  } else if (statusDiscount == "1" && resolutionDiscount == "1") {
    return "descuento Aprobado";
  }
  return "descuento Solicitado";
}

bool isActiveDiscount(String? statusDiscount) {
  return statusDiscount != null;
}

bool isApprovedDiscount(
    String? statusDiscount, String? resolutionDiscount) {

  if (statusDiscount == "1" && resolutionDiscount == "0") {
    return false;
  } else if (statusDiscount == "1" && resolutionDiscount == "1") {
    return true;
  }
  return false;
}

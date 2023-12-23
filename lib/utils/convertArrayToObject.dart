Map<String, String> convertArrayToObject(List<dynamic> data) {
  Map<String, String> result = {};

  for (var d in data) {
    if (d["Caracteristica"] != null && d["Valor"] != null) {
      result[d["Caracteristica"]!] = d["Valor"]!;
    }
  }

  return result;
}

class Unit {
  final int unitId;
  final int estadoId;
  final int projectId;
  final String unitName;
  final String salePrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  Unit({
    required this.unitId,
    required this.estadoId,
    required this.projectId,
    required this.unitName,
    required this.salePrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      unitId: json['Id_unidad'],
      estadoId: json['Id_estado'],
      projectId: json['Id_proyecto'],
      unitName: json['Nombre_unidad'],
      salePrice: json['Precio_Venta'],
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? DateTime.now()
          : DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
  return {
    "unitId": unitId,
    "estadoId": estadoId,
    "projectId": projectId,
    "unitName": unitName,
    "salePrice": salePrice
  };
}
}

class Project {
  final int projectId;
  final List<Unit> units;

  Project({
    required this.projectId,
    required this.units,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    final List<dynamic> unitList = json['UNIDADs'];
    final List<Unit> units =
        unitList.map((unitJson) => Unit.fromJson(unitJson)).toList();
    return Project(
      projectId: json['Id_proyecto'],
      units: units,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "projectId": projectId,
      "units": units,
    };
  }
}

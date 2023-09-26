class AlbumAdd {
  final int projectId;
  final String albumName;
  final int position;
  final bool isActive;

  AlbumAdd({
    required this.projectId,
    required this.albumName,
    required this.position,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      "idProyecto": projectId,
      "nombreAlbum": albumName,
      "posicion": position,
      "state": isActive ? "1" : "0"
    };
  }
}

class Album {
  final int? projectId;
  final int albumId;
  final String albumName;
  final int position;
  final bool isActive;
  final List<Asset?> assets;
  final Asset? firstAsset;

  Album({
    this.projectId = null,
    required this.albumId,
    required this.albumName,
    required this.position,
    required this.isActive,
    required this.assets,
    this.firstAsset
  });

  Map<String, dynamic> toJson() {
    return {
      "idProyecto": projectId,
      "nombreAlbum": albumName,
      "posicion": position,
      "state": isActive ? "1" : "0"
    };
  }

  factory Album.fromJson(json) {
    List<Asset> assets = [];
    if (json["RECURSOs"] != null) {
      final List<dynamic> assetList = json["RECURSOs"];
      assets = assetList.map((unitJson) => Asset.fromJson(unitJson)).toList();
    }

    return Album(
        albumId: json["Id_albun"],
        albumName: json["Name_albun"],
        position: json["Posicion"],
        isActive: json["State"] == 1 ? true : false,
        firstAsset: assets.length > 0 ? assets[0] : null,
        assets: assets);
  }
}

class Asset {
  final int? albumId;
  final int assetId;
  final int assetType;
  final String assetUrl;
  final int position;
  final bool isActive;
  final bool isFavorite;

  Asset({
    required this.assetId,
    required this.albumId,
    required this.assetType,
    required this.assetUrl,
    required this.position,
    required this.isActive,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      "idAlbum": albumId,
      "idTipoRecurso": assetType,
      "urlRecurso": assetUrl,
      "posicion": position,
      "state": isActive ? "1" : "0",
      "favorito": isFavorite ? "1" : "0",
    };
  }

  factory Asset.fromJson(json) {
    return Asset(
      albumId: json["Id_albun"],
      assetId: json["Id_recurso"],
      assetType: json["Id_tipo_recurso"],
      assetUrl: json["Url_recurso"],
      position: json["Posicion"],
      isActive: json["State"].toString() == "1" ? true : false,
      isFavorite: json["Favorito"].toString() == "1" ? true : false,
    );
  }
}

class AssetType {
  final int assetTypeId;
  final String assetTypeName;

  AssetType({
    required this.assetTypeId,
    required this.assetTypeName,
  });

  factory AssetType.fromJson(json) {
    return AssetType(
      assetTypeId: json["Id_tipo_recurso"],
      assetTypeName: json["Nombre"],
    );
  }
}

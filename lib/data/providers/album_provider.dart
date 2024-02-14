import 'dart:convert';
import 'package:developer_company/data/models/album_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class AlbumProvider {
  final httpAdapter = HttpAdapter();

  Future<Album?> postNewAlbum(Album albumData) async {
    final response = await httpAdapter.postApi("orders/v1/crearAlbum",
        jsonEncode(albumData.toJson()), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      return Album.fromJson(responseMap["album"]);
    } else {
      throw Exception("failed to post Album 📰");
    }
  }

  Future<Album?> updateAlbum(Album albumData) async {
    final response = await httpAdapter.putApi(
        "orders/v1/actualizarAlbum/${albumData.albumId.toString()}",
        jsonEncode(albumData.toJson()),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      return Album.fromJson(responseMap["body"]);
    } else {
      throw Exception("Failed to update Album 😱");
    }
  }

  Future<List<Album>?> getAlbums(String projectId, bool isActive) async {
    final response = await httpAdapter.getApi(
        "orders/v1/albumsProyect/proyect/$projectId/idStat/${isActive ? "1" : "0"}",
        {});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> albums = jsonResponse["ALBUNs"];
      return albums.map((json) => Album.fromJson(json)).toList();
    } else {
      return null;
      // throw Exception("Failed to get active Albums 🍸");
    }
  }

  Future<List<AssetType>> getAssetTypes() async {
    final response = await httpAdapter.getApi("orders/v1/listaRecursos", {});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => AssetType.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get asset types 🚀");
    }
  }

  Future<Asset?> postNewAsset(Asset assetData) async {
    final response = await httpAdapter.postApi("orders/v1/crearRecurso",
        json.encode(assetData), {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Asset.fromJson(jsonResponse["album"]);
    } else {
      throw Exception("Failed to post new asset 🥊");
    }
  }

  Future<Asset?> updateAsset(Asset assetData) async {
    final response = await httpAdapter.putApi(
        "orders/v1/actualizarRecurso/${assetData.assetId}",
        json.encode(assetData),
        {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Asset.fromJson(jsonResponse["body"]);
    } else {
      throw Exception("Failed to post new asset 🥊");
    }
  }

  Future<List<Asset>?> getAssetsByAlbum(String projectId, bool isActive) async {
    final response = await httpAdapter.getApi(
        "orders/v1/recursos/album/$projectId/idStat/${isActive ? "1" : "0"}",
        {});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> assets = jsonResponse["RECURSOs"];
      return assets.map((json) => Asset.fromJson(json)).toList();
    } else {
      return null;
      // throw Exception("Failed to get resources 🤖");
    }
  }

  Future<List<Asset>> getFavoritesByProject(String projectId) async {
    final response = await httpAdapter
        .getApi("orders/v1/albumsProyectFavoritas/$projectId", {});

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      List<dynamic> albums = responseJson["ALBUNs"];

      List<Asset> assets = albums
          .map((album) {
            List<dynamic> favoriteAssets = album["RECURSOs"];
            return favoriteAssets.map((fa) => Asset.fromJson(fa));
          })
          .expand((assetsIterable) => assetsIterable)
          .toList();

      return assets;
    } else {
      return [];
    }
  }
}

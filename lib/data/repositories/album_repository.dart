import 'package:developer_company/data/models/album_model.dart';

abstract class AlbumRepository {
  Future<Album?> postNewAlbum(Album albumData);
  Future<Album?> updateAlbum(Album albumData);
  Future<List<Album>?> getAlbums(String projectId, bool isActive);
  Future<List<AssetType>> getAssetTypes();
  Future<Asset?> postNewAsset(Asset assetData);
  Future<Asset?> updateAsset(Asset assetData);
  Future<List<Asset>?> getAssetsByAlbum(String albumId, bool isActive);
    Future<List<Asset>> getFavoritesByProject(String projectId);
}

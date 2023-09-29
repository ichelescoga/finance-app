import 'package:developer_company/data/models/album_model.dart';
import 'package:developer_company/data/providers/album_provider.dart';
import 'package:developer_company/data/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumProvider albumProvider;

  AlbumRepositoryImpl(this.albumProvider);

  Future<Album?> postNewAlbum(Album albumData) async {
    return this.albumProvider.postNewAlbum(albumData);
  }

  Future<Album?> updateAlbum(Album albumData) async {
    return this.albumProvider.updateAlbum(albumData);
  }

  Future<List<Album>?> getAlbums(String projectId, bool isActive) async {
    return this.albumProvider.getAlbums(projectId, isActive);
  }

  Future<List<AssetType>> getAssetTypes() async {
    return this.albumProvider.getAssetTypes();
  }

  Future<Asset?> postNewAsset(Asset assetData) async {
    return this.albumProvider.postNewAsset(assetData);
  }

  Future<Asset?> updateAsset(Asset assetData) async {
    return this.albumProvider.updateAsset(assetData);
  }

  Future<List<Asset>?> getAssetsByAlbum(String albumId, bool isActive) async {
    return this.albumProvider.getAssetsByAlbum(albumId, isActive);
  }

  Future<List<Asset>> getFavoritesByProject(String projectId) async {
    return this.albumProvider.getFavoritesByProject(projectId);
  }
}

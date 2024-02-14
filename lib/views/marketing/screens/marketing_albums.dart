import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/widgets/image_description_card.dart";
import "package:developer_company/widgets/video_card.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class MarketingAlbums extends StatefulWidget {
  final bool isWatchMode;
  final bool shouldFetchAlbums;
  final Function(bool, int) handleUpdateListAlbums;

  const MarketingAlbums(
      {Key? key,
      required this.isWatchMode,
      required this.shouldFetchAlbums,
      required this.handleUpdateListAlbums})
      : super(key: key);

  @override
  _MarketingAlbumsState createState() => _MarketingAlbumsState();
}

class _MarketingAlbumsState extends State<MarketingAlbums> {
  final user = container.read(userProvider);
  final AlbumRepository albumProvider = AlbumRepositoryImpl(AlbumProvider());
  List<Album> albums = [];
  bool shouldBePaused = false;

  _fetchAlbums() async {
    albums.clear();
    EasyLoading.show();
    final projectId = user.project.projectId;

    if (widget.isWatchMode == false) {
      final assetsDisables = await albumProvider.getAlbums(projectId, false);
      if (assetsDisables != null) {
        albums.addAll(assetsDisables);
      }
    }
    final assetsEnables = await albumProvider.getAlbums(projectId, true);
    if (assetsEnables != null) {
      albums.addAll(assetsEnables);
      setState(() {
        albums.sort((a, b) => a.position.compareTo(b.position));
      });
    }
    EasyLoading.dismiss();
    widget.handleUpdateListAlbums(false, albums.length);
  }

  @override
  void didUpdateWidget(MarketingAlbums oldWidget) {
    if (widget.shouldFetchAlbums) {
      _fetchAlbums();
    }
    super.didUpdateWidget(oldWidget);
  }

  _handleUpdateAlbumMainInfo(bool needUpdate) {
    if (needUpdate) {
      _fetchAlbums();
    }
  }

  _handleNextPageMaintenanceAlbumDetails(Album album) async {
    setState(() {
      shouldBePaused = true;
    });
    final result = await Get.toNamed(
        RouterPaths.MARKETING_MAINTENANCE_DETAIL_ALBUM,
        arguments: {
          "albumId": album.albumId,
          "albumIsActive": album.isActive,
          "albumName": album.albumName,
          "albumPosition": album.position,
        });

    _handleUpdateAlbumMainInfo(result);
  }

  _handleNextPageAlbumDetail(Album album) async {
    Get.toNamed(RouterPaths.MARKETING_DETAIL_ALBUM,
        arguments: {"albumId": album.albumId, "albumName": album.albumName});
  }

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isWatchMode
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];

              final firstAsset = album.firstAsset;
              final firstAssetType = albums[index].firstAsset?.assetType;

              return (firstAsset == null || firstAssetType == 2)
                  ? ImageDescriptionCard(
                      showChecked: false,
                      handleCheckedImageCard: (p0) {},
                      imageUrl: album.firstAsset?.assetUrl,
                      description: album.albumName,
                      rightIcons: [
                        RightIcon(
                            onPressRightIcon: () =>
                                _handleNextPageAlbumDetail(album),
                            rightIcon: Icons.arrow_forward)
                      ],
                    )
                  : VideoCard(
                      showChecked: false,
                      handleCheckedVideoCard: (p0) {},
                      shouldBePausedReset: (value) =>
                          setState(() => shouldBePaused = false),
                      shouldBePaused: shouldBePaused,
                      mute: true,
                      autoPlay: true,
                      looping: true,
                      videoUrl: firstAsset.assetUrl,
                      showFavorite: false,
                      description: album.albumName,
                      initialFavorite: false,
                      onFavoriteChanged: (bool _) {},
                      rightIcons: [
                        RightIcon(
                            onPressRightIcon: () =>
                                _handleNextPageAlbumDetail(album),
                            rightIcon: Icons.arrow_forward)
                      ],
                    );
            },
          )
        : ReorderableListView(
            onReorder: ((oldIndex, newIndex) async {
              if (newIndex > oldIndex) newIndex--;
              final album = albums.removeAt(oldIndex);
              setState(() {
                albums.insert(newIndex, album);
              });
              final projectId = user.project.projectId;

              Album albumData1 = Album(
                  projectId: int.tryParse(projectId),
                  albumId: albums[oldIndex].albumId,
                  albumName: albums[oldIndex].albumName,
                  position: oldIndex,
                  isActive: true,
                  assets: []);

              Album albumData2 = Album(
                  projectId: int.tryParse(projectId),
                  albumId: albums[newIndex].albumId,
                  albumName: albums[newIndex].albumName,
                  position: newIndex,
                  isActive: true,
                  assets: []);
              await albumProvider.updateAlbum(albumData1);
              await albumProvider.updateAlbum(albumData2);
            }),
            children: [
              for (final album in albums)
                (album.firstAsset == null || album.firstAsset?.assetType == 2)
                    ? ImageDescriptionCard(
                        showChecked: false,
                        handleCheckedImageCard: (p0) {},
                        key: ValueKey(album.albumId),
                        imageUrl: album.firstAsset?.assetUrl,
                        description: album.albumName,
                        rightIcons: [
                            RightIcon(
                                onPressRightIcon: () =>
                                    _handleNextPageMaintenanceAlbumDetails(
                                        album),
                                rightIcon: Icons.arrow_forward)
                          ])
                    : VideoCard(
                        showChecked: false,
                        handleCheckedVideoCard: (p0) {},
                        key: ValueKey(album.albumId),
                        shouldBePausedReset: (value) =>
                            setState(() => shouldBePaused = false),
                        shouldBePaused: shouldBePaused,
                        mute: true,
                        autoPlay: true,
                        looping: true,
                        videoUrl: album.firstAsset!.assetUrl,
                        showFavorite: false,
                        description: album.albumName,
                        initialFavorite: false,
                        onFavoriteChanged: (bool _) {},
                        rightIcons: [
                            RightIcon(
                                onPressRightIcon: () =>
                                    _handleNextPageMaintenanceAlbumDetails(
                                        album),
                                rightIcon: Icons.arrow_forward)
                          ])
            ],
          );
  }
}

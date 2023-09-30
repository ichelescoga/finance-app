import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/widgets/image_description_card.dart";
import "package:developer_company/widgets/video_card.dart";
import "package:developer_company/widgets/zoom_image_dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";

class MarketingAlbumDetail extends StatefulWidget {
  final bool isWatchMode;
  final int albumId;
  final bool shouldFetchAssets;
  final bool resetVideoCheckCards;
  final Function(bool)? updateVideoResetCheckCards;

  final bool resetImageCheckCards;
  final Function(bool)? updateImageResetCheckCards;

  final Function(bool) handleUpdateListAssets;
  final Function(int) handleUpdateAssetsLength;
  final Function(Asset) openEditAssetDialog;
  final Function(bool)? updateInfoHasChange;
  final Function(bool, Asset) handleCheckedResources;

  const MarketingAlbumDetail(
      {Key? key,
      required this.isWatchMode,
      this.resetVideoCheckCards = false,
      this.updateVideoResetCheckCards,
      this.resetImageCheckCards = false,
      this.updateImageResetCheckCards,
      required this.albumId,
      required this.shouldFetchAssets,
      required this.handleUpdateListAssets,
      required this.handleUpdateAssetsLength,
      required this.openEditAssetDialog,
      required this.handleCheckedResources,
      this.updateInfoHasChange})
      : super(key: key);

  @override
  _MarketingAlbumDetailState createState() => _MarketingAlbumDetailState();
}

class _MarketingAlbumDetailState extends State<MarketingAlbumDetail> {
  final user = container.read(userProvider);
  final AlbumRepository albumProvider = AlbumRepositoryImpl(AlbumProvider());
  List<Asset> assets = [];

  _fetchAssets() async {
    assets.clear();
    EasyLoading.show();
    final projectId = user?.project.projectId;
    if (projectId == null) return [];

    if (widget.isWatchMode == false) {
      final assetsDisables = await albumProvider.getAssetsByAlbum(
          widget.albumId.toString(), false);

      if (assetsDisables != null) {
        assets.addAll(assetsDisables);
      }
    }
    final assetsEnables =
        await albumProvider.getAssetsByAlbum(widget.albumId.toString(), true);

    if (assetsEnables != null) {
      assets.addAll(assetsEnables);
    }
    setState(() {
      assets.sort((a, b) => a.position.compareTo(b.position));
    });

    EasyLoading.dismiss();
    widget.handleUpdateAssetsLength(assets.length);
    widget.handleUpdateListAssets(false);
  }

  _handleUpdateAssetFavorite(bool isFavorite, Asset asset) async {
    final Asset assetData = Asset(
        assetId: asset.assetId,
        albumId: widget.albumId,
        assetType: asset.assetType,
        assetUrl: asset.assetUrl,
        position: asset.position,
        isActive: asset.isActive,
        isFavorite: isFavorite);
    await albumProvider.updateAsset(assetData);
  }

  @override
  void didUpdateWidget(MarketingAlbumDetail oldWidget) {
    if (widget.shouldFetchAssets) {
      _fetchAssets();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _fetchAssets();
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
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: assets.length,
            itemBuilder: (context, index) {
              final asset = assets[index];

              final assetUrl = asset.assetUrl;
              final firstAssetType = assets[index].assetType;
              return (firstAssetType == 2)
                  ? ImageDescriptionCard(
                      resetCheckImageCard: widget.resetImageCheckCards,
                      updateResetCheckCard: widget.updateImageResetCheckCards,
                      showChecked: true,
                      handleCheckedImageCard: (p0) =>
                          widget.handleCheckedResources(p0, asset),
                      imageUrl: assetUrl,
                      description: "",
                      rightIcons: [
                        RightIcon(
                            rightIcon: Icons.open_in_browser,
                            onPressRightIcon: () {
                              _showImageZoom(context, assetUrl);
                            })
                      ],
                    )
                  : VideoCard(
                      resetCheckCard: widget.resetVideoCheckCards,
                      updateResetCheckCard: widget.updateVideoResetCheckCards,
                      showChecked: true,
                      handleCheckedVideoCard: (p0) =>
                          widget.handleCheckedResources(p0, asset),
                      shouldBePausedReset: (p0) {},
                      shouldBePaused: false,
                      mute: true,
                      autoPlay: true,
                      looping: true,
                      videoUrl: assetUrl,
                      showFavorite: false,
                      description: "",
                      initialFavorite: false,
                      onFavoriteChanged: (bool _) {},
                    );
            },
          )
        : ReorderableListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            onReorder: ((oldIndex, newIndex) async {
              if (newIndex > oldIndex) newIndex--;
              final album = assets.removeAt(oldIndex);
              setState(() {
                assets.insert(newIndex, album);
              });

              Asset assetData1 = Asset(
                  assetId: assets[oldIndex].assetId,
                  albumId: widget.albumId,
                  assetType: assets[oldIndex].assetType,
                  assetUrl: assets[oldIndex].assetUrl,
                  position: oldIndex,
                  isActive: assets[oldIndex].isActive,
                  isFavorite: assets[oldIndex].isFavorite);
              Asset assetData2 = Asset(
                  assetId: assets[newIndex].assetId,
                  albumId: widget.albumId,
                  assetType: assets[newIndex].assetType,
                  assetUrl: assets[newIndex].assetUrl,
                  position: newIndex,
                  isActive: assets[newIndex].isActive,
                  isFavorite: assets[newIndex].isFavorite);

              await albumProvider.updateAsset(assetData1);
              await albumProvider.updateAsset(assetData2);
              if (newIndex == 0) {
                widget.updateInfoHasChange!(true);
              }
            }),
            children: [
              for (final asset in assets)
                (asset.assetType == 2)
                    ? ImageFavoriteDescriptionCard(
                        key: ValueKey(asset.assetId),
                        imageUrl: asset.assetUrl,
                        description: "",
                        onFavoriteChanged: (bool isFavorite) =>
                            _handleUpdateAssetFavorite(isFavorite, asset),
                        initialFavorite: asset.isFavorite,
                        rightIcons: [
                            RightIcon(
                              onPressRightIcon: () =>
                                  _showImageZoom(context, asset.assetUrl),
                              rightIcon: Icons.open_in_browser_sharp,
                            ),
                            RightIcon(
                              onPressRightIcon: () =>
                                  widget.openEditAssetDialog(asset),
                              rightIcon: Icons.edit_square,
                            )
                          ])
                    : VideoCard(
                        key: ValueKey(asset.assetId),
                        showChecked: false,
                        handleCheckedVideoCard: (p0) {},
                        shouldBePausedReset: (p0) {},
                        shouldBePaused: false,
                        mute: true,
                        autoPlay: true,
                        looping: true,
                        videoUrl: asset.assetUrl,
                        showFavorite: true,
                        description: "",
                        initialFavorite: asset.isFavorite,
                        onFavoriteChanged: (bool isFavorite) =>
                            _handleUpdateAssetFavorite(isFavorite, asset),
                        rightIcons: [
                            RightIcon(
                              onPressRightIcon: () =>
                                  widget.openEditAssetDialog(asset),
                              rightIcon: Icons.edit_square,
                            )
                          ])
            ],
          );
  }

  _showImageZoom(BuildContext context, String image) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return ZoomImageDialog(
            imageLink: image,
          );
        }));
  }
}

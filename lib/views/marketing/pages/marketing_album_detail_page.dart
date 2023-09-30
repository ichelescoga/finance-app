import 'package:developer_company/data/models/album_model.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/services/pdf_download_share.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/views/marketing/screens/marketing_album_detail.dart';
import 'package:developer_company/widgets/rounded_container_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class MarketingAlbumDetailPage extends StatefulWidget {
  const MarketingAlbumDetailPage({Key? key}) : super(key: key);

  @override
  _MarketingAlbumDetailPageState createState() =>
      _MarketingAlbumDetailPageState();
}

class _MarketingAlbumDetailPageState extends State<MarketingAlbumDetailPage> {
  final Map<String, dynamic> albumArgs = Get.arguments;

  bool resetCheckedVideos = false;
  bool resetCheckedImages = false;

  List<Asset> checkedImages = [];
  List<Asset> checkedVideos = [];

  bool showShareImages = false;
  bool showShareVideos = false;

  _handleResetVideos(bool state) {
    resetCheckedVideos = state;
  }

  _handleResetImages(bool state) {
    resetCheckedImages = state;
  }

  _removeAssetChecked(Asset asset) {
    if (asset.assetType == 2) {
      checkedImages.remove(asset);
    } else {
      checkedVideos.remove(asset);
    }
  }

  _AddAssetChecked(Asset asset) {
    if (asset.assetType == 2) {
      checkedImages.add(asset);
    } else {
      checkedVideos.add(asset);
    }
  }

  _handleCheckedResources(bool isChecked, Asset asset) {
    if (isChecked) {
      _AddAssetChecked(asset);
    } else {
      _removeAssetChecked(asset);
    }

    if (checkedImages.length == 0) {
      setState(() => showShareImages = false);
    } else if (checkedImages.length == 1) {
      setState(() => showShareImages = true);
    }

    if (checkedVideos.length == 0) {
      setState(() => showShareVideos = false);
    } else if (checkedVideos.length == 1) {
      setState(() => showShareVideos = true);
    }
  }

  _shareVideos() async {
    List<String> urlsVideos = [];
    for (final assetVideo in checkedVideos) {
      urlsVideos.add(assetVideo.assetUrl);
    }

    await ShareText(urlsVideos);
    setState(() {
      checkedVideos = [];
    });
    resetCheckedVideos = true;
    showShareVideos = false;
  }

  _shareImages() async {
    List<String> urlsImages = [];
    for (final assetImage in checkedImages) {
      urlsImages.add(assetImage.assetUrl);
    }
    await shareFiles(urlsImages, "Imagen_Proyecto.png");
    setState(() {
      checkedImages = [];
    });
    resetCheckedImages = true;
    showShareImages = false;
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22),
          backgroundColor: AppColors.officialWhite,
          foregroundColor: AppColors.mainColor,
          visible: true,
          curve: Curves.bounceIn,
          direction: SpeedDialDirection.up,
          children: [
            SpeedDialChild(
                label: "Menu Principal",
                labelStyle: TextStyle(color: AppColors.officialWhite),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.officialWhite,
                ),
                backgroundColor: AppColors.mainColor,
                onTap: () => Get.toNamed(RouterPaths.DASHBOARD_PAGE),
                labelBackgroundColor: AppColors.mainColor),
            if (showShareVideos)
              SpeedDialChild(
                  label: "Compartir Videos",
                  labelStyle: TextStyle(color: AppColors.officialWhite),
                  child: Icon(
                    Icons.share,
                    color: AppColors.officialWhite,
                  ),
                  backgroundColor: AppColors.mainColor,
                  onTap: () async => _shareVideos(),
                  labelBackgroundColor: AppColors.mainColor),
            if (showShareImages)
              SpeedDialChild(
                  label: "Compartir Imágenes",
                  labelStyle: TextStyle(color: AppColors.officialWhite),
                  child: Icon(
                    Icons.share,
                    color: AppColors.officialWhite,
                  ),
                  backgroundColor: AppColors.mainColor,
                  onTap: () async => _shareImages(),
                  labelBackgroundColor: AppColors.mainColor),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sun-tornado-white.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 15),
                RoundedContainer(
                    text: albumArgs["albumName"],
                    height: 40,
                    width: Get.width / 1.30,
                    color: AppColors.officialWhite),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(responsive.wp(5)),
                    child: MarketingAlbumDetail(
                      resetImageCheckCards: resetCheckedImages,
                      updateImageResetCheckCards: _handleResetImages,
                      resetVideoCheckCards: resetCheckedVideos,
                      updateVideoResetCheckCards: _handleResetVideos,
                      handleCheckedResources: _handleCheckedResources,
                      openEditAssetDialog: (asset) {},
                      isWatchMode: true,
                      albumId: albumArgs["albumId"],
                      shouldFetchAssets: false,
                      handleUpdateListAssets: (bool shouldFetch) {},
                      handleUpdateAssetsLength: (p0) {},
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

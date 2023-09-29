import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/views/marketing/screens/marketing_album_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketingAlbumDetailPage extends StatefulWidget {
  const MarketingAlbumDetailPage({Key? key}) : super(key: key);

  @override
  _MarketingAlbumDetailPageState createState() =>
      _MarketingAlbumDetailPageState();
}

class _MarketingAlbumDetailPageState extends State<MarketingAlbumDetailPage> {
  final Map<String, dynamic> albumArgs = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: Container(
          child: Padding(
        padding: EdgeInsets.all(responsive.wp(5)),
        child: SafeArea(
          child: MarketingAlbumDetail(
            openEditAssetDialog: (asset) {},
            isWatchMode: true,
            albumId: albumArgs["albumId"],
            shouldFetchAssets: false,
            handleUpdateListAssets: (bool shouldFetch) {},
            handleUpdateAssetsLength: (p0) {},
          ),
        ),
      )),
    );
  }
}

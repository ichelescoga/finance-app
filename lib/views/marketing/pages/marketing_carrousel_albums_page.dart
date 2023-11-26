import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:developer_company/views/marketing/screens/marketing_albums.dart";
import "package:developer_company/widgets/image_description_card.dart";
import "package:developer_company/widgets/rounded_container_text.dart";
import "package:developer_company/widgets/video_card.dart";
import "package:developer_company/widgets/zoom_image_dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class MarketingCarrouselAlbumsPage extends StatefulWidget {
  const MarketingCarrouselAlbumsPage({Key? key}) : super(key: key);

  @override
  _MarketingCarrouselAlbumsPageState createState() =>
      _MarketingCarrouselAlbumsPageState();
}

class _MarketingCarrouselAlbumsPageState
    extends State<MarketingCarrouselAlbumsPage>
    with SingleTickerProviderStateMixin {
  AlbumRepository albumProvider = AlbumRepositoryImpl(AlbumProvider());
  final user = container.read(userProvider);
  List<Asset> favoriteAssets = [];
  late AnimationController _controller;
  // late Animation<double> _animation;

  _retrieveFavoriteAlbums() async {
    favoriteAssets.clear();
    EasyLoading.show();
    final projectId = user?.project.projectId;

    final favorites = await albumProvider.getFavoritesByProject(projectId!);

    favoriteAssets.addAll(favorites);
    setState(() {
      favoriteAssets.sort((a, b) => a.position.compareTo(b.position));
    });

    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    _retrieveFavoriteAlbums();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust the duration as needed
    );

    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOut, // Use your preferred curve
    // );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RouterPaths.DASHBOARD_PAGE);
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.officialWhite,
          onPressed: () => Get.toNamed(RouterPaths.DASHBOARD_PAGE),
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.mainColor,
          ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  RoundedContainer(
                      text: "Material Audio Visual Favorito",
                      height: 40,
                      width: Get.width / 2.00,
                      color: AppColors.officialWhite),
                  Container(
                    width: Get.width,
                    height: Get.height / 4,
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: favoriteAssets.length,
                        itemBuilder: (context, index) {
                          final asset = favoriteAssets[index];
                          final assetUrl = asset.assetUrl;

                          return (asset.assetType == 2)
                              ? Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                      height: Get.height / 5,
                                      child: ImageDescriptionCard(
                                        showChecked: false,
                                        handleCheckedImageCard: (p0) {},
                                        imageUrl: assetUrl,
                                        description: "",
                                        rightIcons: [
                                          RightIcon(
                                              onPressRightIcon: () =>
                                                  _showImageZoom(
                                                      context, assetUrl),
                                              rightIcon:
                                                  Icons.open_in_browser_rounded)
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                      height: Get.height / 5,
                                      child: VideoCard(
                                        showChecked: false,
                                        handleCheckedVideoCard: (p0) {},
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
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ),
                  RoundedContainer(
                      text: "Álbumes del proyecto",
                      height: 40,
                      width: Get.width / 2.40,
                      color: AppColors.officialWhite),
                  SizedBox(height: 30),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: responsive.wp(5), right: responsive.wp(5)),
                      child: SingleChildScrollView(
                        child: MarketingAlbums(
                          isWatchMode: true,
                          shouldFetchAlbums: false,
                          handleUpdateListAlbums: (p0, p1) {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            )),
      ),
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

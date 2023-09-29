import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:developer_company/views/marketing/screens/marketing_albums.dart";
import "package:developer_company/widgets/image_description_card.dart";
import "package:developer_company/widgets/slide_fade_transition_animation.dart";
import "package:developer_company/widgets/video_card.dart";
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
  late Animation<double> _animation;

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

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Use your preferred curve
    );

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

    return Scaffold(
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
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  "Recursos Destacados",
                  style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      color: AppColors.officialWhite,
                      fontWeight: FontWeight.bold),
                ),
                SlideFadeTransition(
                  animation: _animation,
                  child: Container(
                    width: Get.width,
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
                                      width: Get.width - 50,
                                      child: ImageDescriptionCard(
                                        imageUrl: assetUrl,
                                        description: "",
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Container(
                                      width: Get.width - 50,
                                      child: VideoCard(
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
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: responsive.wp(5), right: responsive.wp(5)),
                    child: SingleChildScrollView(
                      child: MarketingAlbums(
                        isWatchMode: true,
                        shouldFetchAlbums: false,
                        handleUpdateListAlbums: (p0) {},
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
    );
  }
}

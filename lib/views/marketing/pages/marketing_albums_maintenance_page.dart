import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/views/marketing/screens/marketing_albums.dart";
import "package:developer_company/widgets/addNewAlbum.dart";
import "package:developer_company/widgets/app_bar_sidebar.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MarketingAlbumsMaintenancePage extends StatefulWidget {
  const MarketingAlbumsMaintenancePage({Key? key}) : super(key: key);

  @override
  _MarketingAlbumsMaintenancePageState createState() =>
      _MarketingAlbumsMaintenancePageState();
}

class _MarketingAlbumsMaintenancePageState
    extends State<MarketingAlbumsMaintenancePage> {
  final user = container.read(userProvider);
  final Map<String, dynamic> dashboardArgs = Get.arguments;
  bool shouldFetchAlbums = false;
  TextEditingController newAlbumController = TextEditingController();
  bool isLoadingAddNewAlbum = false;
  int albumsLength = 0;
  bool isActiveAlbum = true;
  AlbumRepository albumProvider = AlbumRepositoryImpl(AlbumProvider());

  handleUpdateListAlbums(bool shouldFetch, int lengthAlbums) {
    setState(() {
      shouldFetchAlbums = shouldFetch;
      albumsLength = lengthAlbums;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        useScroll: false,
        appBar: CustomAppBarSideBar(
          title: "Álbumes Mercadeo",
          rightActions: [
            IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: AppColors.softMainColor,
                  size: Dimensions.topIconSizeH,
                ),
                onPressed: () {
                  _dialogNewAlbum(context);
                })
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: MarketingAlbums(
                  isWatchMode: dashboardArgs["isWatchMode"],
                  shouldFetchAlbums: shouldFetchAlbums,
                  handleUpdateListAlbums: handleUpdateListAlbums),
            ),
          ],
        ));
  }

  _dialogNewAlbum(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AddNewAlbum(albumsLength: albumsLength ));
        }).then((result) {
      if (result == true) {
        handleUpdateListAlbums(true, 0);
        return;
      }
    });
  }
}

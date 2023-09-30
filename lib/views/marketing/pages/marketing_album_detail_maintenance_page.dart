import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/views/marketing/screens/marketing_album_detail.dart";
import "package:developer_company/widgets/add_asset_by_album_dialog.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";

import "package:get/get.dart";

class MarketingAlbumDetailMaintenancePage extends StatefulWidget {
  const MarketingAlbumDetailMaintenancePage({Key? key}) : super(key: key);

  @override
  _MarketingAlbumDetailMaintenancePageState createState() =>
      _MarketingAlbumDetailMaintenancePageState();
}

class _MarketingAlbumDetailMaintenancePageState
    extends State<MarketingAlbumDetailMaintenancePage> {
  final user = container.read(userProvider);
  final Map<String, dynamic> marketingArgs = Get.arguments;

  final AlbumRepository albumProvider = AlbumRepositoryImpl(AlbumProvider());

  final TextEditingController nameOfAlbumController = TextEditingController();

  List<AssetType> assetTypes = [];
  bool isActiveAlbum = false;
  bool albumMainInfoHasChange = false;
  bool isEditAlbumTitle = false;
  int albumId = 0;
  int assetsLength = 0;
  bool isLoadingAssetTypes = false;
  bool shouldFetchAssets = false;
  Asset? editingAsset;

  _handleUpdateAlbumMainInfo() async {
    final projectId = user?.project.projectId;

    Album albumData = Album(
        projectId: int.tryParse(projectId!),
        albumId: marketingArgs["albumId"],
        albumName: nameOfAlbumController.text,
        position: marketingArgs["albumPosition"],
        isActive: isActiveAlbum,
        assets: []);

    await albumProvider.updateAlbum(albumData);
    updateInfoHasChange(true);
  }

  _retrieveAssetTypes() async {
    setState(() => isLoadingAssetTypes = true);
    assetTypes = await albumProvider.getAssetTypes();
    setState(() => isLoadingAssetTypes = false);
  }

  updateInfoHasChange(bool hasChange) {
    albumMainInfoHasChange = hasChange;
  }

  handleUpdateListAssets(bool shouldFetch) {
    setState(() {
      shouldFetchAssets = shouldFetch;
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveAssetTypes();
    // TODO CONSIDER RETRIEVE THE DATA FROM EP, Even previous page only for ID.
    nameOfAlbumController.text = marketingArgs["albumName"];
    isActiveAlbum = marketingArgs["albumIsActive"];
    albumId = marketingArgs["albumId"];
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        onBackFunction: () {
          Get.back(result: albumMainInfoHasChange);
        },
        sideBarList: [],
        useScroll: true,
        appBar: CustomAppBarTitle(
          title: "Album",
          rightActions: [
            if (!isLoadingAssetTypes)
              IconButton(
                  icon: Icon(
                    Icons.add_circle_sharp,
                    color: AppColors.softMainColor,
                    size: Dimensions.topIconSizeH,
                  ),
                  onPressed: () {
                    _dialogNewEditAsset(context, assetTypes, null);
                  })
            else
              Center(
                child: SizedBox(
                    height: Dimensions.topIconSizeH,
                    width: Dimensions.topIconSizeW,
                    child: CircularProgressIndicator()),
              )
          ],
        ),
        child: Column(
          children: [
            CustomInputWidget(
                readOnly: !isEditAlbumTitle,
                controller: nameOfAlbumController,
                label: "Nombre Album",
                hintText: "Nombre Album",
                prefixIcon: Icons.image),
            SwitchListTile(
              title: Text(
                isActiveAlbum ? "Album Activo" : "Album Inactivo",
                style: TextStyle(color: Colors.black),
              ),
              value: isActiveAlbum,
              onChanged: (bool value) {
                if (!isEditAlbumTitle) {
                  EasyLoading.showInfo(
                      "Presione Editar para habilitar esta opción.");
                  return;
                }
                setState(() {
                  isActiveAlbum = value;
                });
              },
              activeColor: AppColors.softMainColor,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    color: isEditAlbumTitle
                        ? AppColors.softMainColor
                        : AppColors.secondaryMainColor,
                    padding: EdgeInsets.only(left: 0, right: 0),
                    onTap: () {
                      if (isEditAlbumTitle) _handleUpdateAlbumMainInfo();
                      setState(() => isEditAlbumTitle = !isEditAlbumTitle);
                    },
                    text: isEditAlbumTitle ? "Guardar Album" : "Editar Album",
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            MarketingAlbumDetail(
              handleCheckedResources: (p0, p1) {},
              updateInfoHasChange: updateInfoHasChange,
              openEditAssetDialog: (asset) {
                _dialogNewEditAsset(context, assetTypes, asset);
              },
              isWatchMode: false,
              albumId: marketingArgs["albumId"],
              shouldFetchAssets: shouldFetchAssets,
              handleUpdateListAssets: (bool shouldFetch) {
                handleUpdateListAssets(shouldFetch);
              },
              handleUpdateAssetsLength: (p0) =>
                  setState(() => assetsLength = p0),
            )
          ],
        ));
  }

  _dialogNewEditAsset(
      BuildContext context, List<AssetType> assetTypes, Asset? editingAsset) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AddAssetByAlbumDialog(
                asset: editingAsset,
                assetsLength: assetsLength,
                assetTypes: assetTypes,
                albumId: marketingArgs["albumId"],
              ));
        }).then((result) {
      if (result == true) {
        handleUpdateListAssets(true);
        setState(() {
          albumMainInfoHasChange = true;
        });
        return;
      }
      editingAsset = null;
    });
  }
}

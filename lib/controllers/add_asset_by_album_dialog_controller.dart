import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';

class AddAssetByAlbumDialogController extends BaseController {
  // final TextEditingController assetName = TextEditingController();
  final TextEditingController assetType = TextEditingController();
  bool assetIsActive = true;
  bool assetIsFavorite = false;

  ImageToUpload asset = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

  final TextEditingController videoUrl = TextEditingController();

  clearAssetByAlbumController() {
    // assetName.clear();
    assetType.clear();
    assetIsActive = true;
    assetIsFavorite = false;
  }
}

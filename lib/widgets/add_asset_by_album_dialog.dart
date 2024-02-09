import "package:developer_company/controllers/add_asset_by_album_dialog_controller.dart";
import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/implementations/upload_image_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/models/image_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/providers/upload_image.provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/data/repositories/upload_image_repository.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/validations/image_button_validator.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/widgets/custom_dropdown_widget.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/elevated_custom_button.dart";
import "package:developer_company/widgets/upload_button_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";
import 'package:uuid/uuid.dart';

class AddAssetByAlbumDialog extends StatefulWidget {
  final List<AssetType?> assetTypes;
  final int albumId;
  final int assetsLength;
  final Asset? asset;

  const AddAssetByAlbumDialog(
      {Key? key,
      required this.assetTypes,
      required this.albumId,
      required this.assetsLength,
      this.asset})
      : super(key: key);

  @override
  _AddAssetByAlbumDialogState createState() => _AddAssetByAlbumDialogState();
}

class _AddAssetByAlbumDialogState extends State<AddAssetByAlbumDialog> {
  final GlobalKey<FormState> _formKeyAddNewAsset = GlobalKey<FormState>();
  final AddAssetByAlbumDialogController _addAssetController =
      AddAssetByAlbumDialogController();

  final AlbumRepository _albumProvider = AlbumRepositoryImpl(AlbumProvider());

  UploadImageRepository uploadImageRepository =
      UploadImageRepositoryImpl(UploadImageProvider());

  var uuid = Uuid();
  bool isActiveAsset = false;
  bool isLoading = false;
  int? assetTypeIdSelected;

  List<String> getAssetTypeNames() {
    return widget.assetTypes
        .map((assetType) => assetType!.assetTypeName)
        .toList();
  }

  getAssetTypeId(String assetTypeName) {
    try {
      final assetType = widget.assetTypes.firstWhere(
        (element) => element!.assetTypeName == assetTypeName,
      );
      setState(() {
        assetTypeIdSelected = assetType!.assetTypeId;
      });
    } catch (e) {
      if (widget.assetTypes.length > 0) {
        setState(() {
          widget.assetTypes[0]!.assetTypeId;
        });
      }
      return -1;
    }
  }

  String getAssetNameById(int assetTypeId) {
    try {
      final assetType = widget.assetTypes
          .firstWhere((element) => element!.assetTypeId == assetTypeId);
      return assetType!.assetTypeName;
    } catch (e) {
      return "";
    }
  }

  _handleAddEditAsset() async {
    if (_formKeyAddNewAsset.currentState!.validate()) {
      setState(() => isLoading = true);
      final assetType = assetTypeIdSelected;
      final uid = uuid.v1();

      String? assetUrl;

      if (assetType == 2) {
        final UploadImage assetImage = UploadImage(
            file: _addAssetController.asset.base64,
            fileName: "${widget.albumId}-$uid",
            transactionType: "albumAssetResource");

        final base64Asset = _addAssetController.asset.base64;
        final needUpdateUrl = _addAssetController.asset.needUpdate;

        if (base64Asset != null && needUpdateUrl) {
          ImageToUpload responseImage =
              await uploadImageRepository.postImage(assetImage);

          final imageLink = responseImage.link;
          if (imageLink == null) {
            EasyLoading.showError("Algo salio mal al subir imagen.");
          } else {
            assetUrl = imageLink;
          }
        } else {
          assetUrl = widget.asset!.assetUrl;
        }
      } else {
        assetUrl = _addAssetController.videoUrl.text;
      }

      if (assetUrl != null) {
        final Asset assetData = Asset(
            assetId: widget.asset == null ? 0 : widget.asset!.assetId,
            albumId: widget.albumId,
            assetType: assetType!,
            assetUrl: assetUrl,
            position: widget.asset != null
                ? widget.asset!.position
                : widget.assetsLength + 1,
            isActive: _addAssetController.assetIsActive,
            isFavorite: _addAssetController.assetIsFavorite);
        if (widget.asset != null) {
          await _albumProvider.updateAsset(assetData);
        } else {
          await _albumProvider.postNewAsset(assetData);
        }
        Navigator.pop(context, true);
      }
      setState(() => isLoading = false);
    } else {
      EasyLoading.showInfo("Verifique Campos");
    }
  }

  @override
  void initState() {
    getAssetTypeId(widget.assetTypes[0]!.assetTypeName);

    final assetIsEditing = widget.asset;
    if (assetIsEditing != null) {
      assetTypeIdSelected = assetIsEditing.assetType;
      final assetTypeName = getAssetNameById(assetIsEditing.assetType);
      getAssetTypeId(assetTypeName);

      setState(() {
        _addAssetController.assetType.text = assetTypeName;
        _addAssetController.assetIsActive = assetIsEditing.isActive;
        _addAssetController.assetIsFavorite = assetIsEditing.isFavorite;
        if (assetIsEditing.assetType == 1) {
          _addAssetController.videoUrl.text = assetIsEditing.assetUrl;
        } else {
          _addAssetController.asset.updateLink(assetIsEditing.assetUrl);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title:
          Text(widget.asset != null ? "Editar Recurso" : "Agregar Recurso"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Form(
            key: _formKeyAddNewAsset,
            child: Column(children: [
              // CustomInputWidget(
              //     controller: _addAssetController.assetName,
              //     validator: (value) => notEmptyFieldValidator(value),
              //     label: "Nombre del Recurso",
              //     hintText: "Nombre del Recurso",
              //     prefixIcon: Icons.image),
              CustomDropdownWidget(
                  labelText: "Tipo de recurso",
                  hintText: "Tipo de recurso",
                  selectedValue: getAssetNameById(assetTypeIdSelected!),
                  items: getAssetTypeNames()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) => notEmptyFieldValidator(value),
                  prefixIcon: const Icon(Icons.person_outline),
                  onValueChanged: (String? newValue) {
                    _addAssetController.assetType.text = newValue!;
                    getAssetTypeId(newValue);
                  }),
              SwitchListTile(
                title: Text(
                  _addAssetController.assetIsActive
                      ? "Recurso Activo"
                      : "Recurso Inactivo",
                  style: TextStyle(color: Colors.black),
                ),
                value: _addAssetController.assetIsActive,
                onChanged: (bool value) {
                  setState(() {
                    _addAssetController.assetIsActive = value;
                  });
                },
                activeColor: AppColors.softMainColor,
              ),
              SwitchListTile(
                title: Text(
                  _addAssetController.assetIsFavorite
                      ? "Favorito"
                      : "No Favorito",
                  style: TextStyle(color: Colors.black),
                ),
                value: _addAssetController.assetIsFavorite,
                onChanged: (bool value) {
                  setState(() {
                    _addAssetController.assetIsFavorite = value;
                  });
                },
                activeColor: AppColors.softMainColor,
              ),
              if (assetTypeIdSelected == 2)
                LogoUploadWidget(
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    uploadImageController: _addAssetController.asset,
                    text: "Imagen",
                    validator: (value) {
                      final assetTypeId = assetTypeIdSelected;
                      if (assetTypeId == 1) return null;
                      if (!_addAssetController.asset.needUpdate) {
                        return null;
                      }

                      return imageButtonValidator(value,
                          validationText: "Imagen es requerida.");
                    })
              else if (assetTypeIdSelected == 1)
                CustomInputWidget(
                    controller: _addAssetController.videoUrl,
                    label: "URL Video",
                    hintText: "URL Video",
                    prefixIcon: Icons.video_file)
            ]),
          ),
        ),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Guardar",
          isLoading: isLoading,
          onPress: () => _handleAddEditAsset(),
        ),
        ElevatedCustomButton(
          color: AppColors.secondaryMainColor,
          text: "Regresar",
          isLoading: isLoading,
          onPress: () => Navigator.pop(context, false),
        )
      ],
    );
  }
}

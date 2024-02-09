import "package:developer_company/data/implementations/Album_repository_impl.dart";
import "package:developer_company/data/models/album_model.dart";
import "package:developer_company/data/providers/album_provider.dart";
import "package:developer_company/data/repositories/album_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/elevated_custom_button.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class AddNewAlbum extends StatefulWidget {
  final int albumsLength;
  const AddNewAlbum({Key? key, required this.albumsLength}) : super(key: key);

  @override
  _AddNewAlbumState createState() => _AddNewAlbumState();
}

class _AddNewAlbumState extends State<AddNewAlbum> {
  TextEditingController albumNameController = TextEditingController();
  bool isActiveAlbum = true;
  final _formKeyAddNewAlbum = GlobalKey<FormState>();
  HttpAdapter httpAdapter = HttpAdapter();
  bool isLoading = false;
  final user = container.read(userProvider);

  final AlbumRepository albumProvider = AlbumRepositoryImpl(AlbumProvider());

  _handleAddNewAlbum() async {
    final projectId = user.project.projectId;

    if (_formKeyAddNewAlbum.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final Album albumData = Album(
            projectId: int.parse(projectId),
            albumId: 0,
            albumName: albumNameController.text,
            position: widget.albumsLength + 1,
            isActive: isActiveAlbum,
            assets: []);

        await albumProvider.postNewAlbum(albumData);
        setState(() => isLoading = false);
        Navigator.pop(context, true);
      } catch (e) {
        EasyLoading.showError("Algo salio mal. Intente Mas Tarde");
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text("Agregar Nuevo Album"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Form(
            key: _formKeyAddNewAlbum,
            child: Column(children: [
              CustomInputWidget(
                  controller: albumNameController,
                  validator: (value) => notEmptyFieldValidator(value),
                  label: "Nombre del Album",
                  hintText: "Nombre del Album",
                  prefixIcon: Icons.image),
              SwitchListTile(
                title: Text(
                  isActiveAlbum ? "Album Activo" : "Album Inactivo",
                  style: TextStyle(color: Colors.black),
                ),
                value: isActiveAlbum,
                onChanged: (bool value) {
                  setState(() {
                    isActiveAlbum = value;
                  });
                },
                activeColor: AppColors.softMainColor,
              ),
            ]),
          ),
        ),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Guardar",
          isLoading: isLoading,
          onPress: () => _handleAddNewAlbum(),
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

import 'dart:io';

import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploaderButton extends StatefulWidget {
  final ValueChanged<String> onImageSelected;

  const ImageUploaderButton({required this.onImageSelected});

  @override
  _ImageUploaderButtonState createState() => _ImageUploaderButtonState();
}

class _ImageUploaderButtonState extends State<ImageUploaderButton> {
  XFile? _pickedFile;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      widget.onImageSelected(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            height: 50.0,
            width: Get.width,
            decoration: const BoxDecoration(
                color: AppColors.mainColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius))),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Logo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.upload,
                  color: Colors.white,
                )
              ],
            )),
          ),
          onTap: () async {
            _selectImage();
          },
        ),
        const SizedBox(height: Dimensions.heightSize),
        Center(
            child: _pickedFile != null
                ? Image.file(File(_pickedFile!.path))
                : const Text('Seleccione un logo por favor.')),
        const SizedBox(height: Dimensions.heightSize),
      ],
    );
  }
}

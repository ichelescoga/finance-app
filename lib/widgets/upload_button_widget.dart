import 'dart:convert';

import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;

class LogoUploadWidget extends StatefulWidget {
  final ImageToUpload uploadImageController;
  final String text;
  final FormFieldValidator<Object>? validator;
  final bool enabled;
  final Icon icon;

  const LogoUploadWidget(
      {required this.uploadImageController,
      required this.text,
      required this.validator,
      this.enabled = true,
      this.icon = const Icon(
        Icons.upload,
        color: Colors.white,
      )});

  @override
  State<LogoUploadWidget> createState() => _LogoUploadWidgetState();
}

class _LogoUploadWidgetState extends State<LogoUploadWidget> {
  final RxString controllerImage = "".obs;

  @override
  Widget build(BuildContext context) {
    final String? linkImage = widget.uploadImageController.link;

    return FormField(
        validator: (value) => widget.validator!(controllerImage.value.isEmpty
            ? null
            : controllerImage.value.isEmpty),
        builder: (state) {
          return Column(
            children: [
              GestureDetector(
                child: Container(
                  height: 50.0,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      color: AppColors
                          .mainColor, // Replace with your desired color
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions
                                .largeTextSize, // Replace with your desired font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        widget.icon,
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  if (!widget.enabled) return;

                  final picker = ImagePicker();
                  final pickedFile =
                      // ignore: deprecated_member_use
                      await picker.getImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    String fileExtension = path.extension(pickedFile.path);
                    controllerImage.value = pickedFile.path;
                    final imageBytes = await pickedFile.readAsBytes();

                    List<int> compressedBytes =
                        await FlutterImageCompress.compressWithList(
                      imageBytes,
                      minHeight: 400,
                      minWidth: 600,
                      quality: 50,
                    );

                    String base64Image = base64Encode(compressedBytes);
                    setState(() {
                      widget.uploadImageController
                          .updateExtensionFile(fileExtension);
                      widget.uploadImageController
                          .updateBase64String(base64Image);
                    });
                  } else {
                    // No image selected.
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    state.errorText ?? "",
                    style: const TextStyle(
                        color: AppColors.redColor,
                        fontSize: Dimensions.smallTextSize),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.heightSize),
              widget.uploadImageController.needUpdate == false &&
                      linkImage != null
                  ? Image.network(linkImage)
                  : Obx(
                      () => Center(
                          child: controllerImage.value.isNotEmpty
                              ? Image.file(
                                  File(controllerImage.value),
                                )
                              : null),
                    ),
            ],
          );
        });
  }
}

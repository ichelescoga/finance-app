import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class LogoUploadWidget extends StatelessWidget {
  final RxString developerLogoController;
  final String text;
  final FormFieldValidator<Object>? validator;

  const LogoUploadWidget(
      {required this.developerLogoController,
      required this.text,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: (value) => validator!(developerLogoController.value.isEmpty
            ? null
            : developerLogoController.value.isEmpty),
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
                          text,
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
                        const Icon(
                          Icons.upload,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      // ignore: deprecated_member_use
                      await picker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    developerLogoController.value = pickedFile.path;
                  } else {
                    // No image selected.
                  }
                },
              ),
              const SizedBox(height: Dimensions.heightSize),
              Obx(
                () => Center(
                    child: developerLogoController.value.isNotEmpty
                        ? Image.file(
                            File(developerLogoController.value),
                          )
                        : null),
              ),
              Text(
                state.errorText ?? "",
                style: const TextStyle(
                    color: AppColors.redColor,
                    fontSize: Dimensions.smallTextSize),
              ),
              const SizedBox(
                height: Dimensions.heightSize,
              ),
            ],
          );
        });
  }
}

import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoomImageDialog extends StatefulWidget {
  final String imageLink;

  ZoomImageDialog({required this.imageLink});

  @override
  _ZoomImageDialogState createState() => _ZoomImageDialogState();
}

class _ZoomImageDialogState extends State<ZoomImageDialog> {
  final TransformationController _controller = TransformationController();

  void resetZoom() {
    _controller.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                color: AppColors.officialWhite,
                child: InteractiveViewer(
                  transformationController: _controller,
                  constrained: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(widget.imageLink, width: Get.width,),
                ),
              ),
              Container(
                color: AppColors.officialWhite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width / 3,
                        child: ElevatedCustomButton(
                          color: AppColors.mainColor,
                          text: "Cerrar",
                          onPress: () => Navigator.pop(context),
                          isLoading: false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: Get.width / 3,
                        child: ElevatedCustomButton(
                          color: AppColors.mainColor,
                          text: "Reiniciar Imagen",
                          onPress: () => resetZoom(),
                          isLoading: false,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

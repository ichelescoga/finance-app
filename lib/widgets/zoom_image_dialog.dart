import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ZoomImageDialog extends StatefulWidget {
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                color: AppColors.officialWhite,
                child: InteractiveViewer(
                  constrained: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(
                      "https://bkt-finance-app.s3.us-east-2.amazonaws.com/dpiupload/1-43af11b0-5a7e-11ee-b2ad-812126d4c813"),
                ),
              ),
              Container(
                color: AppColors.officialWhite,
                child: Row(
                  children: [
                    ElevatedCustomButton(
                      color: AppColors.mainColor,
                      text: "Cerrar",
                      onPress: () => Navigator.pop(context),
                      isLoading: false,
                    ),
                    ElevatedCustomButton(
                      color: AppColors.mainColor,
                      text: "Reiniciar Imagen",
                      onPress: () => resetZoom(),
                      isLoading: false,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// return Scaffold(
//       appBar: AppBar(
//         title: Text("Zoom Page"),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onScaleStart: (ScaleStartDetails details) {
//             print(details);
//             _previousScale = _scale;
//             setState(() {});
//           },
//           onScaleUpdate: (ScaleUpdateDetails details) {
//             print(details);
//             _scale = _previousScale * details.scale;
//             setState(() {});
//           },
//           onScaleEnd: (ScaleEndDetails details) {
//             print(details);

//             _previousScale = 1.0;
//             setState(() {});
//           },
//           child: RotatedBox(
//             quarterTurns: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Transform(
//                 alignment: FractionalOffset.center,
//                 transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
//                 child: Image.network("https://bkt-finance-app.s3.us-east-2.amazonaws.com/dpiupload/1-43af11b0-5a7e-11ee-b2ad-812126d4c813")
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
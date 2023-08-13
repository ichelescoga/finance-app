import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarTwoImages extends StatelessWidget implements PreferredSizeWidget {
  final String leftImage;
  final String rightImage;

  CustomAppBarTwoImages({ required this.leftImage, required this.rightImage});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0.25,
      backgroundColor: AppColors.BACKGROUND, // Define your background color
      leading: Image.asset(
        leftImage, // Use the provided leading image
      ),
      title: const Text(
        'Cotización',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0), // Adjust as needed
          child: Image.asset(
            rightImage, // Use the provided action image
            width: 40, // Adjust the width as needed
          ),
        ),
      ],
    );
  }
}
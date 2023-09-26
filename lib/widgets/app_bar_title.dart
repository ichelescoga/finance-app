import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> rightActions;

  const CustomAppBarTitle({required this.title, this.rightActions = const []});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.BACKGROUND, // Define your background color
      bottomOpacity: 0,
      elevation: 0.0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [...rightActions],
    );
  }
}

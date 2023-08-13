import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarSideBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarSideBar({
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black87),
        onPressed: () {
          if (Scaffold.of(context).isDrawerOpen) {
            Scaffold.of(context).openDrawer();
          } else {
            Scaffold.of(context).openDrawer();
          }
        },
      ),
      actions: [createIconTopProfile()],
      elevation: 0.25,
      backgroundColor: AppColors.BACKGROUND, // Define your background color
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

createIconTopProfile() {
  return IconButton(
    icon: ClipRRect(
      borderRadius: BorderRadius.circular(60.0),
      child: Image.asset(
        'assets/icondef.png',
      ),
    ),
    onPressed: () {},
  );
}

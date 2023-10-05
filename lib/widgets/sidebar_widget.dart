import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/utils/ask_permission.dart';
import 'package:developer_company/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBarWidget extends StatelessWidget {
  final Function onPressedProfile;
  final List<SideBarItem> listTiles;

  const SideBarWidget(
      {Key? key, required this.listTiles, required this.onPressedProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.BACKGROUND,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: listTiles.length + 1, // Add 1 for the DrawerHeader
          itemBuilder: (context, index) {
            if (index == 0) {
              return ProfileWidget(
                onPressedProfile: () => onPressedProfile(),
              );
            }

            final tileData =
                listTiles[index - 1]; // Subtract 1 for the DrawerHeader

            final haveAccess = AskPermission(tileData.requestAction);

            return !haveAccess
                ? Container()
                : ListTile(
                    leading: Icon(
                      tileData.icon,
                      color: Colors.black87,
                    ),
                    title: Text(
                      tileData.title,
                    ),
                    onTap: () {
                      Get.toNamed(tileData.route);
                    },
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  );
          },
        ),
      ),
    );
  }
}

class SideBarItem {
  final String id;
  final IconData icon;
  final String title;
  final String route;
  final String requestAction;

  SideBarItem(
      {required this.icon,
      required this.title,
      required this.route,
      required this.id,
      this.requestAction = ""});
}

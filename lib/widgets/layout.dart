import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/widgets/sidebar_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class Layout extends StatefulWidget {
  final String title;
  final Widget child;
  final List<Map<String, dynamic>> sideBarList;
  const Layout(
      {Key? key,
      required this.title,
      required this.sideBarList,
      required this.child})
      : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.openEndDrawer();
                } else {
                  scaffoldKey.currentState!.openDrawer();
                }
              },
            ),
            actions: [createIconTopProfile()],
            elevation: 0.25,
            backgroundColor: AppColors.BACKGROUND,
            title: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          drawer: SideBarWidget(
              listTiles: widget.sideBarList,
              onPressedProfile: () => Get.back()),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), child: widget.child),
        ),
        onWillPop: () async {
          Get.back(closeOverlays: true);
          return false;
        });
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
}

class Item {
  final IconData icon;
  final String title;
  bool isSelected;

  Item({required this.icon, required this.title, this.isSelected = false});
}

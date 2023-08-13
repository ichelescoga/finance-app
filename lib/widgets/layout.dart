import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:developer_company/widgets/sidebar_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class Layout extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget appBar;
  final List<Map<String, dynamic>> sideBarList;

  const Layout(
      {Key? key,
      required this.sideBarList,
      required this.appBar,
      required this.child,
      })
      : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    
    return WillPopScope(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.BACKGROUND,
          appBar: widget.appBar,
          drawer: SideBarWidget(
              listTiles: widget.sideBarList,
              onPressedProfile: () => Get.back()),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    left: responsive.wp(5), right: responsive.wp(5)),
                child: widget.child,
              )),
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

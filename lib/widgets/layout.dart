import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:developer_company/widgets/sidebar_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class Layout extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget appBar;
  final List<SideBarItem> sideBarList;
  final Widget? actionButton;
  final bool useScroll;
  final Function? onBackFunction;

  const Layout(
      {Key? key,
      required this.sideBarList,
      required this.appBar,
      required this.child,
      this.actionButton,
      this.onBackFunction,
      this.useScroll = true})
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          key: scaffoldKey,
          floatingActionButton: widget.actionButton,
          backgroundColor: AppColors.BACKGROUND,
          appBar: widget.appBar,
          drawer: SideBarWidget(
              listTiles: widget.sideBarList,
              onPressedProfile: () => Get.back()),
          body: widget.useScroll
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: responsive.wp(5), right: responsive.wp(5)),
                    child: widget.child,
                  ))
              : Padding(
                  padding: EdgeInsets.only(
                      left: responsive.wp(5), right: responsive.wp(5)),
                  child: widget.child,
                ),
        ),
        onWillPop: () async {
          final isNotNullFunction = widget.onBackFunction;
          if (isNotNullFunction != null) {
            isNotNullFunction();
          } else {
            Get.back(closeOverlays: true);
          }
          return false;
        });
  }
}

import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/views/home/controllers/login_page_controller.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarSideBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget> rightActions;
  final bool showProfileIcon;

  const CustomAppBarSideBar(
      {required this.title,
      this.showProfileIcon = true,
      this.rightActions = const []});

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
      actions: [
        if (showProfileIcon)
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(60.0),
              child: Image.asset(
                'assets/icondef.png',
              ),
            ),
            onPressed: () {
              _showModalProfile(context);
            },
          ),
        ...rightActions
      ],
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

  _showModalProfile(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return Center(
            child: Container(
              color: Colors.white,
              height: Get.height / 3,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Cerrar Sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.extraLargeTextSize,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Row(
                        children: [
                          Expanded(
                              child: CustomButtonWidget(
                                  color: AppColors.blueColor,
                                  text: "Cerrar Sesión",
                                  onTap: () {
                                    LoginPageController loginController =
                                        LoginPageController();
                                    UnitDetailPageController quoteController =
                                        UnitDetailPageController();
                                    loginController.cleanController();
                                    quoteController.cleanController();

                                    Get.offAllNamed(RouterPaths.HOME_PAGE);
                                  })),
                          Expanded(
                              child: CustomButtonWidget(
                                  text: "Regresar",
                                  onTap: () => Navigator.of(context).pop()))
                        ],
                      )
                    ]),
              ),
            ),
          );
        }));
  }
}

createIconTopProfile(BuildContext context) {
  return IconButton(
    icon: ClipRRect(
      borderRadius: BorderRadius.circular(60.0),
      child: Image.asset(
        'assets/icondef.png',
      ),
    ),
    onPressed: () {
      LoginPageController loginController = LoginPageController();
      UnitDetailPageController quoteController = UnitDetailPageController();
      loginController.cleanController();
      quoteController.cleanController();

      Get.offAllNamed(RouterPaths.HOME_PAGE);
    },
  );
}

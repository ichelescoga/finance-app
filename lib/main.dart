import 'package:developer_company/shared/routes/get_routes.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shared/resources/colors.dart';

Future<void> main() async{
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mainPage = RouterPaths.HOME_PAGE;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      title: 'Empresa financiera',
      builder: (BuildContext? context, Widget? child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primaryColor: AppColors.mainColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.softMainColor,
        ),
      ),
      initialRoute: mainPage,
      getPages: GetRoutes.routes(),
      //initialBinding: MainBinding(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

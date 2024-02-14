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

final container = ProviderContainer();

Future<void> main() async {
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
  void dispose() {
    super.dispose();
    // disposing the globally self managed container.
    container.dispose();
  }

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
          primary: AppColors.softMainColor,
          // onPrimary: Colors.red,
          // primaryContainer: Colors.red,
          // onPrimaryContainer: Colors.red,
          secondary: AppColors.softMainColor,
          // onSecondary: Colors.red,
          // secondaryContainer: Colors.red,
          // onSecondaryContainer: Colors.red,
          // tertiary: Colors.red,
          // onTertiary: Colors.red,
          // tertiaryContainer: Colors.red,
          // onTertiaryContainer: Colors.red,
          // error: Colors.red,
          // onError: Colors.red,
          // errorContainer: Colors.red,
          // onErrorContainer: Colors.red,
          // background: Colors.red,
          // onBackground: Colors.red,
          // surface: Colors.red,
          onSurface: AppColors.mainColor,
          surfaceVariant: AppColors.officialWhite,
          // onSurfaceVariant: Colors.red, //change icons colors
          outline: AppColors.softMainColor,
          // outlineVariant: Colors.red,
          // shadow: Colors.red,
          // scrim: Colors.red,
          // inverseSurface: Colors.red,
          // onInverseSurface: Colors.red,
          // inversePrimary: Colors.red,
          surfaceTint: AppColors.officialWhite,
        ),
        canvasColor: AppColors.officialWhite,

        // brightness: Brightness.light,
        // primaryColorDark: Colors.blue,
        // primaryColorLight: Colors.yellow,
        // scaffoldBackgroundColor: Colors.red,
        // cardColor: Colors.red,
        // dividerColor: Colors.red,
        // highlightColor: Colors.red,
        // splashColor: Colors.red,
        // unselectedWidgetColor: Colors.red,
        // disabledColor: Colors.red,
        // secondaryHeaderColor: Colors.red,
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

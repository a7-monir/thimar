import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/logic/app_theme.dart';
import 'package:thimar/screens/auth/splash.dart';
import 'package:thimar/screens/home/view.dart';
import 'core/design/res/colors.dart';

import 'core/logic/cache_helper.dart';
import 'core/logic/helper_methods.dart';
import 'kiwi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  initKiwi();
  CacheHelper.init();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppTheme.mainColor));

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      saveLocale: true,
      startLocale: Locale('ar'),
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {


return ScreenUtilInit(
  designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context,child){
      return MaterialApp(
        title: 'thimar',
        theme: ThemeData(
          fontFamily: "Tajawal",
          primarySwatch:getMaterialColor(primaryColor.value),
          unselectedWidgetColor:  Color(0xFFF3F3F3)
        ),
        navigatorKey: navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,

         home: SplashView(),


      );

    }

);  }
}


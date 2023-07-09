import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/helper/dio_helper.dart';
import 'package:thimar/screens/auth/change_password/view.dart';
import 'package:thimar/screens/auth/verification/view.dart';
import 'package:thimar/screens/home/main/view.dart';
import 'package:thimar/screens/home/sections/view.dart';
import 'package:thimar/screens/home/view.dart';
import 'helper/bloc_observer.dart';
import 'helper/cache_helper.dart';
import 'kiwi.dart';
import 'screens/auth/login/view.dart';
import 'screens/home/my_account/call_us/view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initKiwi();
  CacheHelper.init();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
         home: LoginView(),

      );

    }

);  }
}


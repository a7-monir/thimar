import 'package:flutter/material.dart';
import 'package:thimar/constant/app_image.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            AppImage('assets/images/logo.png'),

    );
  }
}

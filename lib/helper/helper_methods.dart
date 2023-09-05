import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

 Future navigateTo(Widget page,
    {bool removeHistory = false, bool isReplacement = false}) {
  if (isReplacement ==false &&removeHistory==false) {
 return   Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  } else if (isReplacement) {
   return Navigator.pushReplacement(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  } else {
    return Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => page,
        ),
        (route) => removeHistory);
  }
}

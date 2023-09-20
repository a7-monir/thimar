import 'package:flutter/material.dart';
import 'package:thimar/core/logic/app_theme.dart';

import 'toast.dart';

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

enum MessageType {success,failed,warning}

void showMessage(String msg,{MessageType messageType = MessageType.failed}){
   if(msg.isNotEmpty)
     {
       Toast.show(msg, navigatorKey.currentContext!,
       //     backgroundColor:
       //     messageType==MessageType.warning?Colors.amber
       // :messageType==MessageType.success?AppTheme.mainColor
       // :AppTheme.mainRedColor
       );
     }

}
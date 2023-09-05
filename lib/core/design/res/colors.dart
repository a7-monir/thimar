
  import 'package:flutter/material.dart';


const primaryColor=Color(0xFF4C8613);
 const secondColor = Color(0xFFB9C9A8);
  const secondBtnColor= const Color(0xFF61B80C);
  const mainGreyColor =  const Color(0xFFF3F3F3);
  const thirdColor = const Color(0xFFEBF2E5);
  const mainColorText = const Color.fromARGB(255, 112, 112, 112);
  const mainRedColor = const Color(0xFFFFE1E1);

MaterialColor getMaterialColor(int hex){
  Color color= Color(hex);
  return MaterialColor(hex, {
    50:color.withOpacity(.1),
    100:color.withOpacity(.2),
    200:color.withOpacity(.3),
    300:color.withOpacity(.4),
    400:color.withOpacity(.5),
    500:color.withOpacity(.6),
    600:color.withOpacity(.7),
    700:color.withOpacity(.8),
    800:color.withOpacity(.9),
    900:color.withOpacity(1),
  }) ;
}
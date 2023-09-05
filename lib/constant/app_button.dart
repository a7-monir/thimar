import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/design/res/colors.dart';
import 'package:thimar/helper/app_theme.dart';


enum btnType{elevated,outLine,cancel,off,dottedBorder}

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final btnType type;
 final String text;
 final VoidCallback onTap;
 final double height;
 final double width;
 double? fontSize=15.sp;


  AppButton({super.key,
   required this.text,
   required this.onTap,
   required this.height,
   this.width = double.infinity,
   this.type=btnType.elevated,
   this.fontSize,

 });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color(0x1361B80C),blurRadius: 6,offset:Offset(0, 3),blurStyle: BlurStyle.outer  )
          ]
    ),
      child: type==btnType.outLine
      ?OutlinedButton(
          onPressed: (){
            FocusManager.instance.primaryFocus?.unfocus();
               onTap();
          }, child: Text(text),
      style:OutlinedButton.styleFrom(
          side: BorderSide(color: primaryColor),
        textStyle: TextStyle(fontSize:fontSize,fontWeight: FontWeight.w600 ),
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r)
        ),

      ) ,

      )
          :type==btnType.off
          ?OutlinedButton(
        onPressed: (){
          FocusManager.instance.primaryFocus?.unfocus();
          onTap();
        }, child: Text(text,),
        style:OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey),
          foregroundColor: Colors.grey
        ) ,):
      ElevatedButton(
          onPressed: (){
            FocusManager.instance.primaryFocus?.unfocus();
            onTap();
          }, child: Text(text),
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize:fontSize,fontWeight: FontWeight.w600 ),
        elevation: 0,
        backgroundColor: type==btnType.cancel
            ?Color(0xffFFE1E1)
            :type==btnType.dottedBorder
          ?AppTheme.thirdColor:null,
        foregroundColor: type==btnType.cancel?Color(0xffFF0000):
        type==btnType.dottedBorder
            ?primaryColor:null,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r)
        ),
      ),)

    );






    //   InkWell(
    //   onTap:(){
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     onTap();
    //   } ,
    //   child: Container(
    //     alignment: Alignment.center,
    //     height: height,
    //     width: width,
    //     decoration: BoxDecoration(
    //       color: color,
    //       borderRadius: BorderRadius.circular(15.r),
    //       border: boxBorder
    //     ),
    //     child: Text(
    //       text,
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         color: fontColor,
    //         fontWeight: FontWeight.w800,
    //         fontSize: fontSize,
    //       ),
    //     ),
    //   ),
    // );

  }
}

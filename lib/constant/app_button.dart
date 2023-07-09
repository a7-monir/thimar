import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
 final String text;
 final VoidCallback ontap;
 final double height;
 final double? width;
 final double fontsize;
 final Color color;
 final Color fontcolor ;
 final BoxBorder? boxborder;

 const AppButton({super.key,
   required this.text,
   required this.ontap,
   required this.height,
   this.width,
   required this.fontsize,
   required this.color,
   required this.fontcolor,
   this.boxborder

 });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ontap ,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
          border: boxborder
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: fontcolor,
            fontWeight: FontWeight.w800,
            fontSize: fontsize,
          ),
        ),
      ),
    );

  }
}

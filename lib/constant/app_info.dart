import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_image.dart';
import '../helper/app_theme.dart';

class AppInfo extends StatelessWidget {
 final String icon;
 final String title;
 final Function() ontap;

  const AppInfo({super.key, required this.icon, required this.title, required this.ontap});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontap,
      child: Row(
        children: [
          AppImage('assets/icons/$icon',color: AppTheme.mainColor,),
          SizedBox(width: 9.w,),
          Text(title,
            style: TextStyle(color: AppTheme.mainColor,fontSize:13.sp,fontWeight: FontWeight.bold),),
          const Spacer(),
          AppImage('assets/icons/arrow.png'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/app_theme.dart';
import 'app_image.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 50.w,
      elevation: 0.0,
      centerTitle: true,
      title: Text(title,
          style: TextStyle(
              fontSize: 20.sp,
              color: AppTheme.mainColor,
              fontWeight: FontWeight.bold)),
      leading: Container(
        margin: EdgeInsetsDirectional.only(start: 16.w, top: 8.h, bottom: 8.h),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFE8EDDE),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppImage(
            "assets/icons/icon_back_right.png",
            w: 20.w,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,

    );
  }
}

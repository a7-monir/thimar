import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_image.dart';

import '../helper/app_theme.dart';

class AppQuestions extends StatelessWidget {
  const AppQuestions({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
          style: TextStyle(
              color: AppTheme.mainColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold
          ),),
        Container(
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
            color: AppTheme.thirdColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: AppImage('assets/icons/arrow_down.png'),

        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(title,style: TextStyle(fontSize: 20.sp,color: AppTheme.mainColor,fontWeight: FontWeight.bold)),
      leading: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right: 12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8EDDE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.mainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,

    );
  }
}

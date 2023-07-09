import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_theme.dart';

class AppInfoInput extends StatelessWidget {
  final String hint;
  final TextInputType? textInputType;
  final double? width;
  final Color color;
  const AppInfoInput({super.key, required this.hint, this.textInputType, this.width, required this.color});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        cursorColor: Colors.grey.shade200,
        style: TextStyle(
          fontSize: 15.sp,
          color: AppTheme.mainColor,
        ),
        keyboardType: textInputType,
        decoration: InputDecoration(
          filled: true,
          fillColor:color,
          hintText:hint,

          hintStyle: TextStyle(fontSize: 15,color: AppTheme.maingreycolor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color:Colors.grey.shade300 ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color:Colors.grey.shade300 ),
          ),
        ),
      ),
    );
  }
}

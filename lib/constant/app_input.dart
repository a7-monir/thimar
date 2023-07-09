import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_theme.dart';

class AppCustomInput extends StatelessWidget {
  final String? label;
  final String ? hint ;
  final String prefix;
  final bool obscureText ;
  final bool? isEnabled ;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final dynamic validator;
  final dynamic onSubmit;
  final dynamic suffixPress;
  final IconData? suffix;
  const AppCustomInput({super.key,
     this.label,
    required this.prefix,
    this.textInputType,
    this.hint,
    this.isEnabled,
    required this.obscureText,
    this.controller,
    this.validator,
    this.onSubmit,
    this.suffix,
    this.suffixPress});


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 343.w,
      height: 50.h,
      child: InkWell(

        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          obscureText: obscureText,
          enabled: isEnabled,
          onFieldSubmitted:onSubmit ,
          onTapOutside: (e){
          FocusScope.of(context).requestFocus(new FocusNode());

        },

          style: TextStyle(
            // fontFamily: AppTheme.boldFont,
            color: AppTheme.mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            hintStyle: TextStyle(fontSize: 15.sp,color: AppTheme.mainColor),
            labelStyle: TextStyle(color:AppTheme.mainColor),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('assets/icons/$prefix',width: 14,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: BorderSide(
                width: 0.5.w,
                style: BorderStyle.solid,
                color: AppTheme.mainColor,
              ),
            ),
            contentPadding:  EdgeInsets.only(left: 15.w, top: 20.h, bottom: 20.h, right: 15.w),
            enabledBorder: OutlineInputBorder(
              borderRadius:  BorderRadius.all(
              Radius.circular(15.r),
            ),
              borderSide: BorderSide(
                width: 0.5.w,
                style: BorderStyle.solid,
                color: AppTheme.mainColor,
              ),
            ),

            errorStyle: TextStyle(
              // fontFamily: AppTheme.boldFont,
              color: Colors.red,
          fontSize: 13.sp,
        ),
            suffixIcon: IconButton(icon:Icon(suffix), onPressed: suffixPress,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                  color: Colors.grey.shade200,
              width: 0.5.w,
              style: BorderStyle.solid),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.mainColor,
                  width: 0.5.w,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15.r),
            ),
            filled: true,
            fillColor: Colors.white,

          ),
        ),
      ),
    );
  }
}


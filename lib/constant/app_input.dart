import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_image.dart';

import '../helper/app_theme.dart';


enum InputType {phone,password,email,normal}

class AppInput extends StatefulWidget {
  final InputType inputType;
  final String? label;
  final String ? hint ;
  final int minLine;
  final String? prefix;
  final Widget? suffix;
  final Color color;
  final VoidCallback? onPress;
  final TextInputType? textInputType;
  final TextInputAction inputAction;
  final TextEditingController? controller;
  final dynamic validator;
  final dynamic onSubmit;
  AppInput({super.key,
     this.label,
    this.prefix,
    this.textInputType,
    this.hint,
    this.controller,
    this.validator,
    this.onSubmit,
    this.color= Colors.white,
    this.inputType=InputType.normal,
    this.inputAction=TextInputAction.next,
    this.minLine=1, this.onPress, this.suffix,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {

  bool isPasswordShown=false;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.onPress ,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: TextFormField(
          maxLines: widget.minLine,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.inputType==InputType.phone?TextInputType.phone:null,
          obscureText: widget.inputType==InputType.password && !isPasswordShown,
          textInputAction: widget.inputAction,
          enabled: widget.onPress==null,
          onFieldSubmitted:widget.onSubmit ,
          onTapOutside: (e){
          FocusScope.of(context).requestFocus(new FocusNode());},
          style: TextStyle(
            // fontFamily: AppTheme.boldFont,
            color: Theme.of(context).primaryColor,
            fontSize: 15.sp,
              fontWeight: FontWeight.w600
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: widget.label,
            icon: widget.inputType==InputType.phone ?Container(
                padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                        color: Theme.of(context).unselectedWidgetColor,)),
                child: Column(
                  children: [
                    AppImage('assets/icons/ksa.png',),
                    SizedBox(height: 5.h,),
                    Text(
                      '+966',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: AppTheme.mainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,),
                    ),
                  ],
                )):null,
            hintStyle: TextStyle(fontSize: 12.sp,color: AppTheme.secondColor,),
            labelStyle: TextStyle(fontSize: 15.sp,color: AppTheme.mainColor,fontWeight: FontWeight.w600),
            prefixIcon: widget.prefix!=null?AppImage(widget.prefix!,w: 14.w,):null,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:  BorderRadius.all(
              Radius.circular(15.r),
            ),
              borderSide: BorderSide(
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
            errorStyle: TextStyle(
              // fontFamily: AppTheme.boldFont,
              color: Colors.red,
          fontSize: 15.sp,
        ),
            suffixIcon:widget.inputType==InputType.password?
            GestureDetector(
              child:Icon(isPasswordShown?Icons.visibility_off:Icons.visibility),
              onTap: (){
                isPasswordShown=!isPasswordShown;
                setState(() {

                });
              },):widget.suffix!=null?widget.suffix!:null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                  color:Theme.of(context).unselectedWidgetColor,),
            ),

            filled: true,
            fillColor: widget.color,

          ),

        ),
      ),
    );
  }
}


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_visa.dart';
import 'package:thimar/constant/appbar.dart';
import 'package:thimar/helper/app_theme.dart';

import '../constant/app_button.dart';

class PayView extends StatelessWidget {
  const PayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child:CustomAppBar(title: 'الدفع'),),
      body:  Column(
        children: [
          SizedBox(height: 40.h,),
          AppVisa(color: Colors.black, image: 'visa.png',width: 343.w,
            height: 152.16.h,),
          SizedBox(height: 25.h,),
          AppVisa(color: AppTheme.mainColor, image: 'mastercard.png',width: 343.w,
            height: 152.16.h,),
          SizedBox(height: 25.h,),
          DottedBorder(
            color: AppTheme.mainColor,
            borderType: BorderType.RRect,
            dashPattern: const [6],
            radius: Radius.circular(15.r),
            child: AppButton(
              text: 'إضافة بطاقة',
              onTap: (){},
              height: 54.h,
              width: 342.w,
             type: btnType.dottedBorder,
            ),
          ),


        ],
      ),
    );
  }
}

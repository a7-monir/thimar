import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_visa.dart';

import '../../../../helper/app_theme.dart';

class CardsView extends StatelessWidget {
  const CardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 317.h,
      width: 376.w,
      child: Padding(
        padding: EdgeInsets.only(right: 14.w,left: 14.h,top: 14.h),
        child: Column(
          children: [
            Text('البطاقات المحفوظة',style: TextStyle(
                color: AppTheme.mainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 25.h,),
            SizedBox(
              height: 107.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AppVisa(color: Colors.black, image: 'visa.png',width: 241.w,
                    height: 107.h,),
                  SizedBox(width: 10.w,),
                  AppVisa(color: AppTheme.mainColor, image: 'mastercard.png',width: 241.w,
                    height: 107.h,),
                ],
              ),
            ),
            SizedBox(height: 22.h,),
            Row(
              children: [
                Container(
                  width: 26.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppTheme.thirdcolor,
                  ),
                  child: Image.asset('assets/icons/add.png'),
                  
                ),
                SizedBox(width: 6.w,),
                Text('إضافة بطاقة دفع',style: TextStyle(color: AppTheme.mainColor,fontSize: 17.sp,),),
              ],
            ),
            SizedBox(height: 22.h,),
            AppButton(
                text: 'تأكيد الأختيار',
                ontap: (){Navigator.pop(context);},
                height: 60.h,
                width: 343.w,
                fontsize: 15.sp, color: AppTheme.mainColor, fontcolor: Colors.white)

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_image.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/helper/helper_methods.dart';
import 'package:thimar/screens/my_order.dart';

import '../../main/view.dart';


class FinishOrderView extends StatelessWidget {
  const FinishOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          width: 376.w,
          height: 436.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.h),
            child: Column(
              children: [
                AppImage('assets/images/done.png'),
                SizedBox(height: 20.h,),
                Text('شكرا لك لقد تم تنفيذ طلبك بنجاح',
                  style: TextStyle(color: AppTheme.mainColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),),
                Text('يمكنك متابعة حالة الطلب او الرجوع للرئسيية',
                style: TextStyle(
                  fontSize: 17.sp,
                  color: AppTheme.mainGreyColor
                ),),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    AppButton(
                        text: 'طلباتي',
                        onTap: (){
                          navigateTo(MyOrderView());
                        },
                        height: 60.h,
                        width: 163.w,
                        ),
                    Spacer(),
                    AppButton(
                        text: 'الرئيسية',
                        onTap: (){
                          navigateTo(MainView());

                        },
                      type: btnType.outLine,
                      height: 60.h,
                      width: 163.w,

                        )
                  ],
                )

              ],
            ),
          ),
        ),
    );
  }
}

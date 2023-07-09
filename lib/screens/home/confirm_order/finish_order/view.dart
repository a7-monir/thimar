import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/screens/home/my_order/view.dart';

import '../../view.dart';


class FinishOrderView extends StatelessWidget {
  const FinishOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 376.w,
        height: 436.h,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/images/done.png'),
              SizedBox(height: 20.h,),
              Text('شكرا لك لقد تم تنفيذ طلبك بنجاح',
                style: TextStyle(color: AppTheme.mainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),),
              Text('يمكنك متابعة حالة الطلب او الرجوع للرئسيية',
              style: TextStyle(
                fontSize: 17.sp,
                color: AppTheme.maingreycolor
              ),),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  AppButton(
                      text: 'طلباتي',
                      ontap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>const MyOrderView(),));
                      },
                      height: 60.h,
                      width: 163.w,
                      fontsize: 15.sp,
                      color: AppTheme.mainColor,
                      fontcolor: Colors.white),
                  const Spacer(),
                  AppButton(
                      text: 'الرئيسية',
                      ontap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>const HomeView(),));
                      },
                      height: 60.h,
                      width: 163.w,
                      fontsize: 15.sp,
                      color: Colors.white,
                      fontcolor: AppTheme.mainColor,
                  boxborder: Border.all(color: AppTheme.mainColor,),)
                ],
              )

            ],
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';
import '../../../../../constant/app_info_input.dart';
import '../../../../../constant/appbar.dart';
import '../../../../../helper/app_theme.dart';

class ShahnView extends StatelessWidget {
  const ShahnView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return[
                const CustomAppBar(title: 'شحن الان',) ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w,left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.h,),
                    Text('معلومات المبلغ',
                      style:TextStyle(color: AppTheme.mainColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold) ,),
                    SizedBox(height: 22.h,),
                     AppInfoInput(
                      hint: 'المبلغ الخاص بك',
                      textInputType: TextInputType.phone,
                      color: AppTheme.thirdcolor,
                    ),
                    SizedBox(height: 40.h,),
                    Text('معلومات البطاقة',
                      style:TextStyle(color: AppTheme.mainColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold) ,),
                    SizedBox(height: 22.h,),
                    AppInfoInput(hint: 'الاسم',
                    color: AppTheme.thirdcolor,),
                    SizedBox(height: 20.h,),
                    AppInfoInput(hint: 'رقم البطاقة الائتمانية',
                      textInputType: TextInputType.phone,
                      color: AppTheme.thirdcolor,),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppInfoInput(hint: 'تاريخ الانتهاء',width: 162.w,textInputType: TextInputType.datetime,color: AppTheme.thirdcolor,),
                        AppInfoInput(hint: 'الرقم المتسلسل',width: 162.w,textInputType: TextInputType.visiblePassword,color: AppTheme.thirdcolor,),
                      ],
                    )




                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: AppButton(text: 'دفع',
                ontap: (){},
                height: 60.h,
                width: 343.w,
                fontsize: 15.sp,
                color: AppTheme.mainColor,
                fontcolor: Colors.white),
          )
        ],
      )
    );
  }
}

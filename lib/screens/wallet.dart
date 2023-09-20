import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/design/res/app_button.dart';

import '../core/design/res/app_image.dart';
import '../core/design/res/appbar.dart';
import '../core/logic/app_theme.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child:CustomAppBar(title: 'المحفظة'),),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:168.h,
                width: 343.w,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('رصيدك',
                      style: TextStyle(
                        color: AppTheme.mainColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 17.h,),
                    Text('225 ر.س',
                      style: TextStyle(
                        color: AppTheme.mainColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              DottedBorder(
                  color: AppTheme.mainColor,
                  borderType: BorderType.RRect,
                  dashPattern: const [6],
                  radius: Radius.circular(15.r),
                  child:
                  AppButton(
                    text: 'اشحن الآن',
                    height: 54.h,
                    width: 343.w,
                    type: btnType.dottedBorder,
                    onTap: (){
                    },

                  )),
              SizedBox(height: 60.h,),
              Padding(
                padding:EdgeInsets.only(right:12.w,left: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('سجل المعاملات',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppTheme.mainColor,
                        fontWeight: FontWeight.bold,
                      ),),
                    Text('عرض الكل',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppTheme.mainColorText,
                      ),)
                  ],
                ),
              ),
              SizedBox(height: 22.h,),
              SizedBox(
                height:83.h,
                width: 343.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w,left: 13.w,top: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImage('assets/icons/arrow_top.png'),
                      SizedBox(width: 10.w,),
                      Column(
                        children: [
                          Text('شحن المحفظة',
                            style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text('225 ر.س',
                            style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),),


                        ],
                      ),
                      const Spacer(),
                      Text('27,يونيو,2021',style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.mainColorText,
                      ),)
                    ],
                  ),
                ),

              ),
              SizedBox(height: 20.h,),
              SizedBox(
                height:83.h,
                width: 343.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w,left: 13.w,top: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImage('assets/icons/arrow_top.png'),
                      SizedBox(width: 10.w,),
                      Column(
                        children: [
                          Text('شحن المحفظة',
                            style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text('225 ر.س',
                            style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),),


                        ],
                      ),
                      const Spacer(),
                      Text('27,يونيو,2021',style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.mainColorText,
                      ),)
                    ],
                  ),
                ),

              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.only(right: 16.w,left: 15.w),
                child: Row(
                  children: [
                    AppImage('assets/icons/red_arrow.png',),
                    SizedBox(width: 9.w,),
                    Text('دفعت مقابل هذا الطلب',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp),),
                    const Spacer(),
                    Text('27,يونيو,2021',style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.mainColorText,
                    ),)

                  ],
                ),
              ),
              SizedBox(height: 24.h,),
              Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Text('طلب #4587',
                  style: TextStyle(
                      color: AppTheme.mainColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.only(right: 24.w,left: 27.w),
                child: Row(
                  children: [
                    AppImage('assets/items/1.png'),
                    SizedBox(width: 5.w,),
                    AppImage('assets/items/2.png'),
                    SizedBox(width: 5.w,),
                    AppImage('assets/items/3.png'),
                    SizedBox(width: 5.w,),
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppTheme.thirdColor,
                      ),
                      child: Center(
                        child: Text('+2',
                          style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const Spacer(),
                    Text('180 ر.س',
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: AppTheme.mainColor),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

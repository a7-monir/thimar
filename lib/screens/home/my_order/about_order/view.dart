import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';

import '../../../../constant/appbar.dart';
import '../../../../helper/app_theme.dart';

class AboutOrderView extends StatelessWidget {
  const AboutOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const CustomAppBar(title: 'تفاصيل الطلب'),
                ];
              },
              body:SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left:16.w,right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start ,
                            children: [
                              Text(
                                'طلب #4587',
                                style: TextStyle(
                                    color: AppTheme.mainColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '27 يونيو 2023',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppTheme.maingreycolor),
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/items/1.png'),
                                  SizedBox(width: 5.w,),
                                  Image.asset('assets/items/2.png'),
                                  SizedBox(width: 5.w,),
                                  Image.asset('assets/items/3.png'),
                                  SizedBox(width: 5.w,),
                                  Container(
                                    height: 25.h,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.thirdcolor,
                                    ),
                                    child: Center(
                                      child: Text('+2',
                                        style: TextStyle(
                                            color: AppTheme.mainColor,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 70.w,
                                height: 23.h,
                                decoration: BoxDecoration(
                                    color: AppTheme.thirdcolor,
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Center(
                                  child: Text('منتهي',style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 11.sp
                                  ),),
                                ),
                              ),
                              Text('180 ر.س',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppTheme.mainColor),),
                              Container(
                                height: 24.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: AppTheme.thirdcolor,
                                  borderRadius: BorderRadius.circular(5),

                                ),
                                child: Image.asset('assets/icons/arrow_right.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Text('عنوان التوصيل',
                        style: TextStyle(
                            color: AppTheme.mainColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('المنزل',style: TextStyle(color: AppTheme.mainColor,fontSize: 14.sp),),
                              Text('شقة 40',style: TextStyle(color: Colors.grey,fontSize: 12.sp),),
                              Text('شارع العلياالرياض12521السعودية',style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          const Spacer(),
                          Image.asset('assets/images/location.png'),

                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Text('ملخص الطلب',
                        style: TextStyle(
                            color: AppTheme.mainColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),),
                      SizedBox(height: 10.h,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:const Color(0xFFF3F8EE),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('إجمالي المنتجات',
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 15.sp),),
                                  Text('180ر.س',style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('سعر التوصيل',
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 15.sp),),
                                  Text('40ر.س',style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('المجموع',
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 15.sp),),
                                  Text('180ر.س',style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('تم الدفع بواسطة', style: TextStyle(
                                  color: AppTheme.mainColor,
                                  fontSize: 17.sp),),
                                  SizedBox(width: 15.w,),
                                  Image.asset('assets/icons/visa2.png')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ) ),
          Padding(
            padding: EdgeInsets.only(bottom: 17.h),
            child: AppButton(
                text: 'إلغاء الطلب',
                ontap: (){},
                height: 60.h,
                width:343.w,
                fontsize: 15.sp, color: const Color(0xFFFFE1E1), fontcolor: Colors.red),
          )
        ],
      ),
    );
  }
}

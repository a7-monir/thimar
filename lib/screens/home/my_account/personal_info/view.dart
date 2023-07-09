import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/appbar.dart';

import '../../../../constant/app_button.dart';
import '../../../../helper/app_theme.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
            return[
              const CustomAppBar(title: 'البيانات الشخصية'),
            ];
          },
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 33.h,),
                    Image.asset('assets/images/user.png'),
                    SizedBox(height: 5.h,),
                    Text('محمد علي',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.mainColor,
                      ),),
                    Text('+96654787856',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: AppTheme.maingreycolor,
                      ),),
                    SizedBox(height: 18.h,),
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFFF5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/user.png',color: AppTheme.mainColor,),
                            SizedBox(width: 12.w,),
                            Column(
                              children: [
                                Text('اسم المستخدم',style: TextStyle(
                                  color: AppTheme.maingreycolor,
                                  fontSize: 15.sp,
                                ),),
                                Text('محمد علي',style: TextStyle(
                                  color: AppTheme.mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                                ),)

                              ],
                            )
                          ],
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 60.h,
                      child: TextFormField(

                        decoration: InputDecoration(
                          prefixIcon:Image.asset('assets/icons/user.png',color: AppTheme.mainColor,),
                          hintText:'اسم المستخدم',
                          hintStyle: TextStyle(
                          color: AppTheme.maingreycolor,
                          fontSize: 15.sp,
                        ),
                          filled: true,
                          fillColor: const Color(0xFFFAFFF5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.grey.shade300 ),
                            borderRadius: BorderRadius.circular(15),
                        ),

                        ),
                      ),
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFFAFFF5),
                                  border: Border.all(color: Colors.grey.shade300)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  const Image(image: AssetImage('assets/icons/ksa.png')),
                                  Text(
                                    '+966',
                                    style: TextStyle(
                                        color: AppTheme.mainColor, fontSize: 15.sp),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 4,
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFAFFF5),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey.shade300)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Row(
                                  children: [
                                    Image.asset('assets/icons/phoneicon.png'),
                                    SizedBox(width: 12.w,),
                                    Column(
                                      children: [
                                        Text('رقم الجوال',style: TextStyle(
                                          color: AppTheme.maingreycolor,
                                          fontSize: 15.sp,
                                        ),),
                                        Text('5498874',style: TextStyle(
                                            color: AppTheme.mainColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold
                                        ),)

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),)
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFAFFF5),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/city.png',color: AppTheme.mainColor,),
                            SizedBox(width: 12.w,),
                            Column(
                              children: [
                                Text('المدينة',style: TextStyle(
                                  color: AppTheme.maingreycolor,
                                  fontSize: 15.sp,
                                ),),
                                Text('محمد علي',style: TextStyle(
                                    color: AppTheme.mainColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold
                                ),)

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h,),
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFAFFF5),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: AppTheme.maingreycolor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'كلمة المرور',
                            prefixIcon: Image.asset('assets/icons/lock.png',color: AppTheme.mainColor,),
                            labelStyle: TextStyle(
                            color: AppTheme.maingreycolor,
                            fontSize: 15.sp,
                          ),
                            suffixIcon: Image.asset('assets/icons/arrow.png'),
                          ),
                        )
                      ),
                    ),



                  ],
                ),
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 28.h),
            child: AppButton(
                text: 'تعديل البيانات',
                ontap: (){},
                height: 60.h,
                width: 343.w,
                fontsize: 15.sp,
                color: AppTheme.mainColor,
                fontcolor: Colors.white),
          )
        ],
      ),

    );
  }
}

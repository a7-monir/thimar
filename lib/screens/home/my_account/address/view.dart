import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_adress.dart';
import 'package:thimar/constant/appbar.dart';

import '../../../../constant/app_button.dart';
import '../../../../helper/app_theme.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const CustomAppBar(title: 'العناوين'),
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const AppAddress(),
                SizedBox(
                  height: 20.h,
                ),
                const AppAddress(),
                SizedBox(
                  height: 20.h,
                ),
                const AppAddress(),
                SizedBox(
                  height: 20.h,
                ),
                const AppAddress(),
                SizedBox(
                  height: 20.h,
                ),
                DottedBorder(
                  color: AppTheme.mainColor,
                  borderType: BorderType.RRect,
                  dashPattern: const [6],
                  radius: const Radius.circular(15),
                  child: AppButton(
                    text: 'إضافة عنوان',
                    ontap: (){},
                    height: 54.h,
                    width: 342.w,
                    fontsize: 15.sp,
                    color: AppTheme.thirdcolor,
                    fontcolor: AppTheme.mainColor,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

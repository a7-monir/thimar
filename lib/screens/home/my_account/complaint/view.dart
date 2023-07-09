import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant/app_button.dart';
import '../../../../constant/app_info_input.dart';
import '../../../../constant/appbar.dart';
import '../../../../helper/app_theme.dart';

class ComplaintView extends StatelessWidget {
  const ComplaintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CustomAppBar(title: 'الأقتراحات والشكاوي'),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 40.h,),
                const AppInfoInput(hint: 'الإسم', color: Colors.white),
                SizedBox(height: 10.h,),
                const AppInfoInput(
                    hint: 'رقم الموبايل',
                    color: Colors.white,
                    textInputType: TextInputType.phone),
                SizedBox(height: 10.h,),
                Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.grey.shade200,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppTheme.mainColor,
                      overflow: TextOverflow.fade,
                    ),
                    maxLines: 5,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'الموضوع',
                      hintStyle:
                      TextStyle(fontSize: 15, color: AppTheme.maingreycolor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                AppButton(
                    text: 'إرسال',
                    ontap: (){
                      Navigator.pop(context);
                    },
                    height: 60.h,
                    width: 343.w,
                    fontsize: 15.sp,
                    color: AppTheme.mainColor,
                    fontcolor: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

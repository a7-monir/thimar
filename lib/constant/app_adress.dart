import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_theme.dart';

class AppAddress extends StatelessWidget {
  const AppAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.mainColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('المنزل',
                  style: TextStyle(color: AppTheme.mainColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),),
                Text('العنوان : 119 طريق الملك عبدالعزيز',
                  style: TextStyle(color: AppTheme.mainColor,
                    fontSize: 14.sp,
                  ),),
                Text('الوصف',
                  style: TextStyle(color: AppTheme.maingreycolor,
                    fontSize: 14.sp,
                  ),),
                Text('رقم الجوال',
                  style: TextStyle(color: AppTheme.maingreycolor,
                    fontSize: 14.sp,
                  ),),
              ],
            ),
            const Spacer(),
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                  color:const Color(0xFFFFE3E3) ),
              child: Image.asset('assets/icons/trash.png'),
            ),
            const SizedBox(width: 5,),
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                  color:AppTheme.thirdcolor ),
              child: Image.asset('assets/icons/edit.png'),
            ),
          ],
        ),
      ),
    );
  }
}

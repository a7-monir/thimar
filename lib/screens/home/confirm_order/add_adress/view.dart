import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_adress.dart';
import 'package:thimar/constant/app_button.dart';

import '../../../../helper/app_theme.dart';

class AddAdressView extends StatelessWidget {
  const AddAdressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 413.h,
      width: 376.w,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('العناوين',style: TextStyle(
                color: AppTheme.mainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 5.h,),
            const AppAddress(),
            SizedBox(height: 20.h,),
            const AppAddress(),
            SizedBox(height: 20.h,),
            DottedBorder(
              color: AppTheme.mainColor,
              borderType: BorderType.RRect,
              dashPattern: const [6],
              radius: const Radius.circular(15),
              child: AppButton(
                  text: 'إضافة عنوان جديد',
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
      ),

    );
  }
}

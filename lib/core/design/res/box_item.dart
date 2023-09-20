import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/app_theme.dart';
import 'app_image.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            AppImage('assets/items/tomato.png'),
            Container(
              width: 54.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppTheme.mainColor
                ,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),),
              ),
              child: Text('45%-',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),),
            ),
          ],
        ),
        Text('طماطم',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          color: AppTheme.mainColor,
        ),),
        Text('السعر/1كجم',style: TextStyle(

            fontSize: 12.sp,
            color:AppTheme.mainColorText
        ),),
        Row(
          children: [
            Row(
              children: [
                Text('45ر.س',
                  style: TextStyle(
                    color: AppTheme.secondBtnColor,
                    fontSize:16.sp,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(width: 5.w,),
                Text('56ر.س',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppTheme.mainColor,
                    fontSize:12.sp,

                  ),),
              ],
            ),
            SizedBox(width: 25.w,),
            SizedBox(
              height: 30.h,
              width: 30.w,
              child: FittedBox(
                child: FloatingActionButton(
                    onPressed: (){},
                    backgroundColor: AppTheme.secondBtnColor,

                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,),
                    elevation: 0.0,
                    child: const Icon(Icons.add,size: 35,)
                ),
              ),
            )

          ],
        ),
      ],
    );

  }
}
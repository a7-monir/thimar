import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_theme.dart';

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
            Image.asset('assets/items/tomato.png'),
            Container(
              width: 54.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppTheme.mainColor
                ,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),),
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
            color:AppTheme.maingreycolor
        ),),
        Row(
          children: [
            Row(
              children: [
                Text('45ر.س',
                  style: TextStyle(
                    color: AppTheme.secondbtncolor,
                    fontSize:16.sp,
                    fontWeight: FontWeight.bold,
                  ),),
                const SizedBox(width: 5,),
                Text('56ر.س',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppTheme.mainColor,
                    fontSize:12.sp,

                  ),),
              ],
            ),
            const SizedBox(width: 25,),
            SizedBox(
              height: 30.h,
              width: 30.w,
              child: FittedBox(
                child: FloatingActionButton(
                    onPressed: (){},
                    backgroundColor: AppTheme.secondbtncolor,

                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
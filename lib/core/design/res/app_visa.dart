import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';


class AppVisa extends StatelessWidget {
 final Color color;
 final String image;
 final double height;
 final double width;

  const AppVisa({super.key, required this.color, required this.image, required this.height, required this.width});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),

        child:Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.w,top: 16.h,left: 25.w,bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 15.h,
                        width: 15.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Center(
                          child:AppImage('assets/icons/check.png',color: color,),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      AppImage('assets/icons/trash.png',color: Colors.white,),
                      const Spacer(),
                      AppImage('assets/icons/$image',color: Colors.white,),
                    ],
                  ),
                  const Spacer(),
                  Text('Mohamed ali',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                  const Spacer(),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('VALID DATE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 5.sp,
                                color: Colors.white),),
                          Text('06/22',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white),),
                        ],
                      ),
                      const Spacer(),
                      Text('0197  ****  ****  ****  ',
                        style:TextStyle ( fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            AppImage('assets/images/mask.png',),

          ],
        ) ,
    );
  }
}

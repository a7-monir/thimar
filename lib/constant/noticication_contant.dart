import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/app_theme.dart';

class NotificationsContent extends StatelessWidget {
  final String icon;
  final String title;
  final String hint;
  final String time;

  const NotificationsContent({super.key, required this.icon, required this.title, required this.hint, required this.time});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 33.h,
            width: 33.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.thirdcolor,
            ),
            child: Image.asset(icon),
          ),
        ),
        SizedBox(width: 15.w,),
        Expanded(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(title,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black
                ),),
              Text(hint,
                //maxLines: 2,
                overflow:TextOverflow.fade,
                softWrap: true,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,


                ),
              ),
              Text(time,
                style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black
                ),),
            ],
          ),
        )
      ],
    );

  }
}

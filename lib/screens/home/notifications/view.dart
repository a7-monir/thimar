import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/noticication_contant.dart';
import 'package:thimar/helper/app_theme.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
          color: AppTheme.mainColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(

          children: [
            const NotificationsContent(
                icon: 'assets/icons/note.png',
                title: 'تم قبول طلبك وجاري تحضيره الأن',
                hint: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                time: 'منذ ساعتان'),
            SizedBox(height: 20.h,),
            const NotificationsContent(
                icon: 'assets/icons/minlogo.png',
                title:'رسالة إدارية' ,
                hint: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                time: 'منذ ساعتان'),
            SizedBox(height: 20.h,),
            const NotificationsContent(
                icon: 'assets/icons/%.png',
                title:'عروض جديدة بإنتظارك' ,
                hint: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                time: 'منذ ساعتان'),




          ],
        ),
      ),
    );
  }
}

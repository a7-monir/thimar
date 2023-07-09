import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant/appbar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CustomAppBar(title: 'عن التطبيق'),
          ];
        },
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Image.asset('assets/images/logo.png')

          ],
        ),
      ),
    );
  }
}

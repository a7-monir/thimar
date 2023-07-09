import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_questions.dart';
import 'package:thimar/constant/appbar.dart';
import 'package:thimar/helper/app_theme.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return[ const CustomAppBar(title: 'أسئلة متكررة')
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 26.w,left:26.w ),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => AppQuestions(title: 'كل ما تريد معرفته عن أكواد الخصم/ الكوبونات'),
                    separatorBuilder: (context, index) => SizedBox(height: 30.h,),
                    itemCount: 15),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

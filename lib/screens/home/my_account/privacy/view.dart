import 'package:flutter/material.dart';
import 'package:thimar/constant/appbar.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const CustomAppBar(title: 'سياسة الخصوصية'),];
        },
        body: Container(),
      ),
    );
  }
}

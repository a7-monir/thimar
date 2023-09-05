

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_theme.dart';

class CustomTitle extends StatelessWidget {

  final String text;
  final String title;
  final VoidCallback onTap;

  const CustomTitle({super.key, required this.text, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
    child: Row(
      children: [
        Text(
          title,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppTheme.mainColor,
            ),
          ),
        ),
      ],
    ),
    );
  }
}
class CustomOnlyTitle extends StatelessWidget {
  final String title;
  final Color color;
  const CustomOnlyTitle({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/app_theme.dart';

class AppCustomCounter extends StatefulWidget {
  final double height;
  final double width;
  final double iconHeight;
  final double iconWidth;
  final double fontSize;

  const AppCustomCounter({super.key,
    required this.height,
    required this.width,
    required this.iconHeight, required this.iconWidth, required this.fontSize});

  @override
  State<AppCustomCounter> createState() => _AppCustomCounterState();
}

class _AppCustomCounterState extends State<AppCustomCounter> {
  int num=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: const Color(0xFFEBF2E5),
      ),
      width: widget.width,
      height:  widget.height,
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          children: [
            SizedBox(
              height: widget.iconHeight,
              width: widget.iconWidth,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: (){
                    num++;
                    setState(() {});
                  },
                  backgroundColor: Colors.white,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none),
                  elevation: 0.0,
                  child: Icon(Icons.add,color:  AppTheme.mainColor,size: 35,),),
              ),
            ),
            const Spacer(),
            Text('$num',style:TextStyle(color:  AppTheme.mainColor,fontSize:widget.fontSize),),
            const Spacer(),
            SizedBox(
              height: widget.iconHeight,
              width: widget.iconHeight,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: (){
                    if(num>1){
                      num--;
                    }
                    setState(() {});
                  },

                  backgroundColor: Colors.white,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none),
                  elevation: 0.0,
                  child: Icon(Icons.remove,color:  AppTheme.mainColor,size: 35,),),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
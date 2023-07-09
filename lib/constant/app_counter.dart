
import 'package:flutter/material.dart';

import '../helper/app_theme.dart';

class AppCustomCounter extends StatefulWidget {
  final double height;
  final double width;
  final double iconheight;
  final double iconwidth;
  final double fontsize;

  const AppCustomCounter({super.key,
    required this.height,
    required this.width,
    required this.iconheight, required this.iconwidth, required this.fontsize});

  @override
  State<AppCustomCounter> createState() => _AppCustomCounterState();
}

class _AppCustomCounterState extends State<AppCustomCounter> {
  int num=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFEBF2E5),
      ),
      width: widget.width,
      height:  widget.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            SizedBox(
              height: widget.iconheight,
              width: widget.iconwidth,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: (){
                    setState(() {
                      num++;
                    });
                  },
                  backgroundColor: Colors.white,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  elevation: 0.0,
                  child: Icon(Icons.add,color:  AppTheme.mainColor,size: 35,),),
              ),
            ),
            const Spacer(),
            Text('$num',style:TextStyle(color:  AppTheme.mainColor,fontSize:widget.fontsize),),
            const Spacer(),
            SizedBox(
              height: widget.iconheight,
              width: widget.iconheight,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: (){
                    setState(() {
                      if(num>1){
                        num--;
                      }
                    });
                  },

                  backgroundColor: Colors.white,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
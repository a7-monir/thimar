import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double? h, w;
  final BoxFit? fit;
  final Color? color;
  const AppImage(this.url, {Key? key, this.w, this.h,this.fit,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(url.startsWith("assets"))
      {
        return Image.asset(
          url,
          width: w,
          height: h,
          fit: fit,
        );
      }
    else if (url.endsWith("svg"))
        {
          return SvgPicture.asset(url);

        }
    else if (url.startsWith('https')){
      return Image.network(
        url,
        width: w,
        height: h,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Text("Error"),
      );
    }
    else {
      return Container();
    }


  }
}

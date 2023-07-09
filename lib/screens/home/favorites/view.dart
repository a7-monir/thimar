import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../constant/box_item.dart';

import '../../../helper/app_theme.dart';


class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المفضلة',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.mainColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:  163/200,
                crossAxisSpacing: 40,
            ),
            itemCount: 8,

            itemBuilder: (contex,i){
              return TextButton(
                  onPressed: (){},
                  child: Column(
                    children: const [
                      ItemBox(),
                    ],
                  ));
            },

          ),
        ),
      ),

    );
  }
}

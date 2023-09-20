
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/screens/auth/login.dart';


import '../../core/design/res/app_image.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../main/view.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  goToHomePage()async{
    if (CacheHelper.getUserToken() == null || CacheHelper.getUserToken() == '') {
      navigateTo(LoginView(),);
    } else {
      navigateTo(MainView(),);
    }
  }

  void initState() {
    Timer(
      const Duration(seconds: 2),
          () {
        goToHomePage();
      },
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/background_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeInDown(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 120.h, left: 13.w),
                        alignment: Alignment.topCenter,
                        child:AppImage('assets/icons/w.png',w: 100.w,),

                      ),
                    ),
                    SlideInUp(
                      child:AppImage( 'assets/icons/h.png',w: 100.w,)
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.h, right: 50.w),
                      child: SlideInLeft(
                        // manualTrigger: true,
                        child:AppImage('assets/icons/a.png', w: 100.w,)

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.h, left: 105.w),
                      child: SlideInRight(
                        child:AppImage('assets/icons/t.png', w: 100.w,),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              bottom: -60,
              right: -130,
              // alignment: Alignment.bottomRight,
              child: AppImage( 'assets/icons/top-view-assortment-vegetables-paper-bag.png',w: 400.w, fit: BoxFit.cover),

            ),
          ],
        ),
      ),
    );
  }
}

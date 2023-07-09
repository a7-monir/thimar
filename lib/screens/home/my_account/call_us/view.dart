import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_info_input.dart';
import 'package:thimar/constant/appbar.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CallUsView extends StatelessWidget {
  CallUsView({Key? key}) : super(key: key);


  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CustomAppBar(title: 'تواصل معنا'),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 240.h,
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 198.h,
                          width: 342.w,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),),
                      Positioned(
                        right: 16.w,
                        left: 16.w,
                        top: 130.h,
                        child: Container(
                          height: 119.h,
                          width: 312.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 16.w, top: 16.h, bottom: 16.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppTheme.mainColor,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      '13 شارع الملك فهد , جدة , المملكة العربية السعودية',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_in_talk_rounded,
                                      color: AppTheme.mainColor,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      '+966 054 87452',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: AppTheme.mainColor,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      'info@thimar.com',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'أو يمكنك إرسال رسالة ',
                  style: TextStyle(
                      color: AppTheme.mainColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                const AppInfoInput(hint: 'الإسم', color: Colors.white),
                SizedBox(height: 10.h,),
                const AppInfoInput(
                    hint: 'رقم الموبايل',
                    color: Colors.white,
                    textInputType: TextInputType.phone),
                SizedBox(height: 10.h,),
                Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextFormField(
                    cursorColor: Colors.grey.shade200,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppTheme.mainColor,
                      overflow: TextOverflow.fade,
                    ),
                    maxLines: 5,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'الموضوع',
                      hintStyle:
                          TextStyle(fontSize: 15, color: AppTheme.maingreycolor),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                AppButton(
                    text: 'إرسال',
                    ontap: (){
                      Navigator.pop(context);
                    },
                    height: 60.h,
                    width: 343.w,
                    fontsize: 15.sp,
                    color: AppTheme.mainColor,
                    fontcolor: Colors.white)

              ],
            ),
          ),
        ),
      ),
    );
  }
}

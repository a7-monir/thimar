import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_input.dart';
import 'package:thimar/constant/app_loading.dart';
import '../constant/appbar.dart';
import '../features/address/bloc.dart';
import '../helper/app_theme.dart';
import 'package:geocoding/geocoding.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
 // final Completer<GoogleMapController> _completer = Completer();

  static const LatLng sourceLocation = LatLng(31.037933, 31.381523);




  Set<Marker> markers = {};



  final bloc = KiwiContainer().resolve<AddressBloc>();
  int type=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(title: 'إضافة عنوان')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400.h,
              child: GoogleMap(
                  initialCameraPosition:
                      const CameraPosition(target: sourceLocation, zoom: 14.5),
                  onTap: (location) async{
                    print(location.latitude);
                    print(location.longitude);
                    markers.add(Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(location.latitude, location.longitude),


                    ));
                    bloc.position = await placemarkFromCoordinates(location.latitude,location.longitude);
                    print(bloc.position[0].locality);
                    bloc.isDefault=1;
                    print(bloc.isDefault);
                    setState(() {
                      bloc.lat=location.latitude;
                      bloc.lng=location.longitude;
                    });
                  },
                  markers: markers,),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 52.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(
                           // vertical: 12.h,
                            horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(14, 0, 0, 0),
                          spreadRadius: -1,
                          blurRadius: 15,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "نوع العنوان",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0xFF8B8B8B),
                          ),
                        ),
                        Spacer(),
                        DefaultTabController(
                          length: 2,
                          child: Container(
                            width: 160.w,
                            height: 50.h,
                            padding: const EdgeInsets.all(5),
                            child: TabBar(
                                onTap: (v) {
                                  v==0 ? bloc.type="المنزل": bloc.type="العمل";
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                labelStyle: TextStyle(
                                    fontSize: 15.sp, ),
                                dividerColor: Colors.red,
                                indicator: BoxDecoration(
                                  color: AppTheme.mainColor,
                                  borderRadius: BorderRadius.circular(10.r),

                                ),
                                unselectedLabelColor: AppTheme.mainColor,
                                tabs:  [
                                  Tab(
                                    text: 'المنزل',
                                  ),

                                  Tab(text: 'العمل'),
                                ]),
                          ),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(
                    height: 14.h,
                  ),
                  AppInput(
                    inputType: InputType.phone,
                    controller: bloc.phoneController,
                    label: 'أدخل رقم الجوال',
                  ),
                  AppInput(
                    controller: bloc.descriptionController,
                    label: 'الوصف',
                  ),
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if(state is AddAddressLoadingState){
                        return AppLoading();
                      }else{
                        return AppButton(
                          text: "إضافة العنوان",
                          onTap: () {
                            bloc.add(AddAddressStartEvent(
                                type: bloc.type,
                                location: bloc.position[0].locality,
                                description: bloc.descriptionController.text,
                                phone: bloc.phoneController.text,
                                lat: bloc.lat!,
                                lng: bloc.lng!,
                                isDefault: bloc.isDefault,

                            ));
                          },
                          height: 60.h,
                          width: 343.w,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> typeAdd = ["0"];
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import 'package:thimar/core/logic/app_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/design/res/app_failed.dart';
import '../core/design/res/app_input.dart';
import '../core/design/res/appbar.dart';
import '../features/contact/bloc.dart';

class ContactUsView extends StatefulWidget {
  ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final bloc = KiwiContainer().resolve<ContactBloc>()..add(ContactStartEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(title: 'تواصل معنا'),
      ),
      body: BlocBuilder(
        buildWhen: (previous, current) =>
        previous != current && current is ContactLoadingState ||
            current is ContactSuccessState ||
            current is ContactFailedState,
        bloc: bloc,
        builder: (context, state) {
          if (state is ContactLoadingState){
            return AppLoading();
          }
          else if (state is ContactSuccessState){
            var data = state.model.data;
           return  SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
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
                              initialCameraPosition: CameraPosition(
                                target: LatLng(data.lat,data.lng),
                                zoom: 14.4746,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          ),
                          Positioned(
                            right: 16.w,
                            left: 16.w,
                            top: 130.h,
                            child: Container(
                              height: 119.h,
                              width: 312.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
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
                                          data.location,
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
                                          data.phone,
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
                                          data.email,
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
                    AppInput(
                        label: 'الإسم',
                    controller: bloc.nameController,),
                     AppInput(
                        label: 'رقم الموبايل',
                        textInputType: TextInputType.phone,
                     inputType: InputType.phone,
                     controller:bloc.phoneController,),
                     AppInput(
                        hint: 'عنوان الموضوع',
                     controller: bloc.titleController,),
                    AppInput(
                      label:'الموضوع',
                      minLine: 5,
                      controller: bloc.contentController,

                    ),
                    AppButton(
                      text: 'إرسال',
                      onTap: () {
                        print(bloc.nameController.text);
                        print(bloc.phoneController.text);
                        print(bloc.titleController.text);
                        print(bloc.contentController.text);

                       bloc.add(CreateContactStartEvent(
                           fullname:bloc.nameController.text,
                       phone: bloc.phoneController.text,
                       title: bloc.titleController.text,
                       content: bloc.contentController.text));
                      },
                      height: 60.h,
                      width: 343.w,
                    ),
                  ],
                ),
              ),
            );
          }
          else if(state is ContactFailedState){
           return  AppFailed(msg: state.msg,);
          }
          else{ return AppLoading();}

        },
      ),
    );
  }
}

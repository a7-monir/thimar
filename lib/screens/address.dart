import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import 'package:thimar/core/design/res/colors.dart';
import '../core/design/res/app_button.dart';
import '../core/design/res/app_failed.dart';
import '../core/design/res/app_image.dart';
import '../core/design/res/appbar.dart';
import '../features/address/bloc.dart';
import '../core/logic/app_theme.dart';

class AddressView extends StatefulWidget {
   AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final bloc = KiwiContainer().resolve<AddressBloc>()..add(GetAddressStartEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(title: 'العناوين'),
        ),
        body:
        BlocBuilder(
          bloc: bloc,
          buildWhen: (previous, current) =>
          previous != current && current is GetAddressLoadingState ||
              current is GetAddressSuccessState||
              current is GetAddressFailedState,
          builder: (context, state) {
            if(state is GetAddressLoadingState){
              return AppLoading();
            }else if (state is GetAddressSuccessState){
              var list = state.model.list;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                            height: 120.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.mainColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(list[index].type,
                                        style: TextStyle(color: AppTheme.mainColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),),
                                      Text(list[index].location,
                                        style: TextStyle(color: AppTheme.mainColor,
                                          fontSize: 14.sp,
                                        ),),
                                      Text(list[index].description,
                                        style: TextStyle(color: AppTheme.mainColor,
                                          fontSize: 14.sp,
                                        ),),
                                      Text(list[index].phone,
                                        style: TextStyle(color: AppTheme.mainColor,
                                          fontSize: 14.sp,
                                        ),),
                                    ],
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: (){
                                      bloc.add(DeleteAddressStartEvent(
                                          id: list[index].id,
                                        index: index
                                      ));

                                      bloc.add(GetAddressStartEvent());
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 24.h,
                                      width: 24.w,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),
                                          color:const Color(0xFFFFE3E3) ),
                                      child: AppImage('assets/icons/trash.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  InkWell(
                                    child: Container(
                                      height: 24.h,
                                      width: 24.w,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),
                                          color:AppTheme.thirdColor ),
                                      child: AppImage('assets/icons/edit.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                          itemCount: list.length),

                      SizedBox(
                        height: 20.h,
                      ),
                      DottedBorder(
                        color: primaryColor,
                        borderType: BorderType.RRect,
                        dashPattern: const [6],
                        radius: Radius.circular(15.r),
                        child: AppButton(
                          text: 'إضافة عنوان',
                          onTap: () {},
                          height: 54.h,
                          width: 342.w,
                          type: btnType.dottedBorder,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else if (state is GetAddressFailedState){
              return AppFailed(msg: state.msg);
            }else{
              return AppLoading();
            }

          },
        )
    );
  }
}

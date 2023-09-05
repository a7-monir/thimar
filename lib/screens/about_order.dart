import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/helper/helper_methods.dart';

import '../constant/app_failed.dart';
import '../constant/app_image.dart';
import '../constant/app_loading.dart';
import '../constant/appbar.dart';
import '../features/about_order/bloc.dart';
import '../helper/app_theme.dart';
import 'rate_order.dart';


class AboutOrderView extends StatefulWidget {
  const AboutOrderView({Key? key, required this.clientOrderId,})
      : super(key: key);

  final int clientOrderId;


  @override
  State<AboutOrderView> createState() => _AboutOrderViewState();
}

class _AboutOrderViewState extends State<AboutOrderView> {
  final bloc = KiwiContainer().resolve<AboutOrderBloc>();

  //final cartBloc = KiwiContainer().resolve<ShowCartBloc>();
  @override
  void initState() {
    super.initState();
    bloc.add(AboutOrderStartEvent(id: widget.clientOrderId));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: CustomAppBar(title: 'تفاصيل الطلب'),),
      body: BlocBuilder(
        bloc: bloc,
        buildWhen: (previous, current) =>
        current is AboutOrderLoadingState||
          current is AboutOrderSuccessState||
          current is AboutOrderFailedState,
        builder: (context, state) {
          if (state is AboutOrderLoadingState) {
            return AppLoading();
          }
          else if (state is AboutOrderSuccessState)
          {
            return  Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'طلب ${bloc.model!.data.id}',
                              style: TextStyle(
                                  color: AppTheme.mainColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bloc.model!.data.date,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppTheme.mainGreyColor),
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  bloc.model!.data.products.length < 3 ?
                                  bloc.model!.data.products.length:3, (i) =>
                                    Container(
                                      height: 25.h,
                                      width: 25.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                      ),
                                      child: Center(
                                          child:ClipRRect(
                                              borderRadius: BorderRadius.circular(10.r) ,
                                              child: AppImage(bloc.model!.data.products[i].url,
                                              w: 25.w,
                                              h: 25.h,))
                                      ),
                                    ), ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                bloc.model!.data.products.length <= 3
                                    ?SizedBox():
                                Container(
                                  height: 25.h,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.r),
                                    color: AppTheme.thirdColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+${bloc.model!.data.products.length-3}',
                                      style: TextStyle(
                                          color: AppTheme.mainColor,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 70.w,
                              height: 23.h,
                              decoration: BoxDecoration(
                                  color: bloc.model!.data.status == "in_way"
                                      ? Color(0xFFE6F5F0)
                                      : bloc.model!.data.status == "pending"
                                      ? AppTheme.thirdColor
                                      : bloc.model!.data.status == "canceled"
                                      ? AppTheme.mainRedColor
                                      : Colors.black,
                                  borderRadius:
                                  BorderRadius.circular(5.r)),
                              child: Center(
                                child: Text(
                                  bloc.model!.data.status,
                                  style: TextStyle(
                                      color: bloc.model!.data.status == "in_way"
                                          ? Color(0xFF2D9E78)
                                          : bloc.model!.data.status == "pending"
                                          ? AppTheme.mainColor
                                          : bloc.model!.data.status == "canceled"
                                          ? Colors.red
                                          : Colors.white,
                                      fontSize: 11.sp),
                                ),
                              ),
                            ),
                            Text(
                              '${ bloc.model!.data.orderPrice} ر.س',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppTheme.mainColor),
                            ),
                            Container(
                              height: 24.h,
                              width: 24.w,
                              decoration: BoxDecoration(
                                color: AppTheme.thirdColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: AppImage(
                                  'assets/icons/arrow_right.png'),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'عنوان التوصيل',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المنزل',
                              style: TextStyle(
                                  color: AppTheme.mainColor,
                                  fontSize: 14.sp),
                            ),
                            Text(
                              'شقة 40',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                            Text(
                              'شارع العلياالرياض12521السعودية',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        AppImage('assets/images/location.png')
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'ملخص الطلب',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: const Color(0xFFF3F8EE),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'إجمالي المنتجات',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  '${ bloc.model!.data.orderPrice}ر.س',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'سعر التوصيل',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  '${ bloc.model!.data.deliveryPrice}ر.س',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'المجموع',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  '${ bloc.model!.data.totalPrice.toInt()}ر.س',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'تم الدفع بواسطة ${ bloc.model!.data.payType}',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 17.sp),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child:
                        BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (bloc.model!.data.status == 'pending') {
                              return AppButton(
                                text: 'إلغاء الطلب',
                                onTap: () {
                                  bloc.add(CancelOrderStartEvent(
                                      id: widget.clientOrderId));
                                  Navigator.pop(context);
                                },
                                height: 60.h,
                                width: 343.w,
                                fontSize: 17.sp,
                                type: btnType.cancel,);
                            } else {
                              return AppButton(
                                text: 'تقييم المنتجات',
                                onTap: () {
                                  navigateTo(
                                      RateOrderView(
                                    products: bloc.model!.data,
                                  ));
                                },
                                height: 60.h,
                                width: 343.w,
                                fontSize: 17.sp,);
                            }
                          },
                        )
                    ),
                  ],
                )
            );
          } else if (state is AboutOrderFailedState) {
            return AppFailed(msg: state.error);
          } else {
            return AppLoading();
          }

        },
      ),
    );
  }
}

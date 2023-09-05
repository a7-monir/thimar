import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_failed.dart';

import 'package:thimar/constant/app_input.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/constant/appbar.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/helper/helper_methods.dart';

import '../../../features/get_cart/bloc.dart';
import '../confirm_order/view.dart';

class CartView extends StatefulWidget {
  const CartView({
    Key? key,
    this.quantity,
  }) : super(key: key);

  final int? quantity;
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final bloc = KiwiContainer().resolve<ShowCartBloc>()..add(ShowCartStartEvent());
  final deleteBloc = KiwiContainer().resolve<ShowCartBloc>();

  final code = TextEditingController();

  final List<Map> data = List.generate(10, (index) => {'quantity': 1, 'isSelected': false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(70.h),
      child:CustomAppBar(title: 'السلة' ,),),
      body: BlocBuilder(
        buildWhen: (previous, current) =>
        current is ShowCartLoadingState||
        current is ShowCartSuccessState||
        current is ShowCartFailedState,
        bloc: bloc,
        builder: (context, state) {
          if (state is ShowCartLoadingState) {
            return AppLoading();
          } else if (state is ShowCartSuccessState) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bloc.model!.list.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 211, 208, 208)
                                    .withOpacity(0.5),
                                spreadRadius: -7,
                                blurRadius: 20,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 92.w,
                                height: 92.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE8EFE0),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                  bloc.model!.list[index].image,
                                  width: 80,
                                ),
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      bloc.model!.list[index].title,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.mainColor),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "${bloc.model!.list[index].price} ر٫س",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.mainColor),
                                    ),
                                    Container(
                                      width: 77.w,
                                      height: 35.h,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8EFE0),
                                        borderRadius:
                                            BorderRadius.circular(9.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              data[index]['quantity']++;
                                              setState(() {
                                                // isSelected = !isSelected;
                                              });
                                            },
                                            child: Container(
                                              width: 23.w,
                                              height: 23.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.add,
                                                size: 15,
                                                color:AppTheme.mainColor ,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                              data[index]['quantity'].toString(),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: AppTheme.mainColor),
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              if (data[index]['quantity'] > 1) {
                                                data[index]['quantity']--;
                                              } else if (data[index]['quantity'] <= 1) {
                                                data[index]['isSelected'] = !data[index]['isSelected'];
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 23.w,
                                              height: 23.h,
                                              decoration: BoxDecoration(
                                                color:Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.remove,
                                                size: 15,
                                                color: AppTheme.mainColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // data[index].remove(data[index]);
                                  deleteBloc.add(DeleteStartEvens(
                                    id: bloc.model!.list[index].id,
                                    index: index,
                                  ));
                                  bloc.add(ShowCartStartEvent());
                                  setState(() {});
                                  // Toast.show("تم المسح بنجاح", context);
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(37, 255, 0, 0),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/icons/trash.png',
                                    width: 20.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: EdgeInsets.only(
                          right: 10.w,left: 10.w,top: 10),
                      //alignment: Alignment.center,
                     // height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 211, 208, 208)
                                .withOpacity(0.5),
                            spreadRadius: -7,
                            blurRadius: 20,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(

                        children: [
                          Expanded(
                              child: AppInput(
                                hint: 'عندك كوبون ؟ ادخل رقم الكوبون',
                                controller: code,
                              )),
                          SizedBox(width: 10.w,),
                          // Text(
                          //   "عندك كوبون ؟ ادخل رقم الكوبون",
                          //   style: TextStyle(
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.w900,
                          //       color: AppTheme.secondColor),
                          // ),

                          Padding(
                            padding:  EdgeInsets.only(bottom: 16.h),
                            child: AppButton(
                              text: 'تطبيق',
                              onTap: () {
                                bloc.add(AddCouponStartEvent(code: code.text));
                              },
                              height: 39.h,
                              width: 79.w,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'جميع الأسعار تشمل قيمة الضريبة المضافة 15%',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFF707070),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: const Color(0xFFF3F8EE),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'إجمالي المنتجات',
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 12.sp),
                                  ),
                                  Spacer(),
                                  Text(
                                    bloc.model!.totalPriceBeforeDiscount.toString(),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'الخصم',
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 15.sp),
                                  ),
                                  Spacer(),
                                  Text(
                                    bloc.model!.totalDiscount.toString(),
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Divider(
                                color: Color(0xFFE8EFE0),
                                height: 1.0,
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
                                  Spacer(),
                                  Text(
                                    bloc.model!.totalPriceWithVat.toString(),
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppButton(
                        text: 'الانتقال لإتمام الطلب',
                        onTap: () {
                          navigateTo(
                              ConfirmOrderView(model:bloc.model));
                        },
                        height: 60.h,
                        width: 343.w,
                       ),
                  )
                ],
              ),
            ));
          } else if (state is ShowCartFailedState) {
            return AppFailed(msg: state.error);
          } else {
            return AppLoading();
          }
        },
      ),
    );
  }
}

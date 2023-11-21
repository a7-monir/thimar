import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:thimar/core/design/res/app_input.dart';

import 'package:thimar/screens/add_address.dart';
import '../../../features/confirm_order/bloc.dart';

import '../../core/logic/app_theme.dart';

import '../../core/design/res/app_image.dart';
import '../../core/design/res/appbar.dart';
import '../../core/logic/cache_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/logic/toast.dart';
import '../../features/cart/bloc.dart';
import '../../models/user.dart';
import 'add_address/view.dart';
import 'finish_order/view.dart';

class ConfirmOrderView extends StatefulWidget {
  final CartModel? model;
  const ConfirmOrderView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  DateTime date = DateTime.now();
  TimeOfDay? time = TimeOfDay.now();
  final note = TextEditingController();
  String payType = 'wallet';
  final bloc = KiwiContainer().resolve<ConfirmOrderBloc>();
 String ? type;
 String ? location;
 String? addressId;
 String? dataText;
 String? timeText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: CustomAppBar(
          title: 'إتمام الطلب',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(right: 10.w, left: 20.w, top: 10.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الإسم : ${Users.i.fullname}',
                style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'الجوال : ${Users.i.phone}',
                style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اختر عنوان التوصيل',
                    style: TextStyle(
                        color: AppTheme.mainColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 26.w,
                    height: 26.h,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: AppTheme.thirdColor,
                        onPressed: () {
                          navigateTo(AddAddressView());
                        },
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide.none,
                        ),
                        elevation: 0.0,
                        child: Icon(
                          Icons.add,
                          color: AppTheme.mainColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 339.w,
                height: 33.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: AppTheme.mainColor),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 8.0.w,
                  ),
                  child: TextButton(
                    onPressed: ()async {
                  final list =   await showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.r),
                              topLeft: Radius.circular(50.r)),
                        ),
                        context: context,
                        builder: (context) => const AddAddress(),
                      );

                  if(list != null){
                    setState(() {
                      type = list[0];
                      location = list[1];
                      addressId = list[2].toString();

                    });
                  }
                    },
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text('${type}:${location}',

                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppTheme.mainColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'تحديد وقت التوصيل',
                style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 163.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2050),
                        );
                        if (newDate == null) {
                          return;
                        }
                        setState(() {
                          date = newDate;
                        });
                        dataText =DateFormat("yyyy-MM-dd").format(date);
                        print(DateFormat("yyyy-MM-dd").format(date));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'اختر اليوم والتاريخ',
                            style: TextStyle(
                                fontSize: 15.sp, color: AppTheme.mainColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: AppTheme.mainColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 163.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(


                            context: context, initialTime: TimeOfDay.now());
                        if (newTime == null) {
                          return;
                        }
                        setState(() {
                          time = newTime;
                        });
                        timeText="${time?.hour}:${time?.minute}";
                        print(time?.format(context));
                        print(timeText);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'اختر الوقت',
                            style: TextStyle(
                                fontSize: 15.sp, color: AppTheme.mainColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.access_time_outlined,
                            color: AppTheme.mainColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'ملاحظات وتعليمات',
                style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
              AppInput(
                controller: note,
                minLine: 5,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'اختر طريقة الدفع',
                style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              DefaultTabController(
                length: 3,
                child: TabBar(
                    onTap: (v) {
                      v == 0
                          ? payType = 'كاش'
                          : v == 1
                              ? payType = 'البطاقات المدفوعة'
                              : payType = 'المحفظه';
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorWeight: 5,
                    labelStyle:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                    indicator: BoxDecoration(
                      color: AppTheme.mainColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    unselectedLabelColor: AppTheme.mainColor,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppImage('assets/icons/money.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'كاش',
                            )
                          ],
                        ),
                      ),
                      Tab(
                        child: Text(
                          'البطاقات\nالمدفوعه',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Tab(text: 'المحفظة'),
                    ]),
              ),
              SizedBox(
                height: 20.h,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'إجمالي المنتجات',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                          Text(
                            '${widget.model!.totalPriceBeforeDiscount}ر.س',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'سعر التوصيل',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                          Text(
                            '${widget.model!.deliveryCost}ر.س',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الخصم',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                          Text(
                            '${widget.model!.totalDiscount}ر.س',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المجموع',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                          Text(
                            '${widget.model!.totalPriceWithVat}ر.س',
                            style: TextStyle(
                                color: AppTheme.mainColor, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocConsumer(
                bloc: bloc,
                listener: (context, state) {
                 if(state is ConfirmOrderSuccessState){
                   showModalBottomSheet(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.vertical(
                             top: Radius.circular(38.r))),
                     context: context,
                     builder: (context) => const FinishOrderView(),
                   );
                 }else if(state is ConfirmOrderFailedState) {
                   Toast.show(state.msg, context);
                 }
                },
                builder: (context, state) {
                  return AppButton(
                    text: 'إنهاء الطلب',
                    width: 343.w,
                    height: 60.h,
                    onTap: () {
                      bloc.add(ConfirmOrderStartEvent(
                          addressId: addressId,
                          date: dataText,
                          time: timeText,
                          note: note.text,
                          payType:'wallet')
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

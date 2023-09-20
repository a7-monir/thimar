import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../core/design/res/app_failed.dart';
import '../core/design/res/app_image.dart';
import '../core/design/res/app_loading.dart';
import '../core/design/res/appbar.dart';
import '../core/logic/helper_methods.dart';
import '../features/my_order/bloc.dart';
import '../core/logic/app_theme.dart';
import 'about_order.dart';


class MyOrderView extends StatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  final bloc = KiwiContainer().resolve<OrderBloc>()
    ..add(ClientOrderStartEvent(endPoint: 'current'));



  @override
  Widget build(BuildContext context) {
    // final TabController controller = TabController(length: 2);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(title: 'طلباتي'),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20.w,right: 20.w,),
            child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: TabBar(
                          onTap: (v) {
                            bloc.add(ClientOrderStartEvent(
                                endPoint: v == 0 ? 'current' : 'finished'));
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          labelStyle: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          indicator: BoxDecoration(
                            color: AppTheme.mainColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          unselectedLabelColor: AppTheme.mainColor,
                          tabs: const [
                            Tab(
                              text: 'الحاليه',
                            ),
                            Tab(text: 'المنتهية'),
                          ]),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is ClientOrderLoadingState) {
                          return AppLoading();
                        }
                        else if (state is ClientOrderSuccessState) {
                          final list =state.model.list;
                          return Expanded(
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    navigateTo(
                                        AboutOrderView(
                                          clientOrderId: list[index].id,

                                        )).then((x){
                                      bloc.add(ClientOrderStartEvent(endPoint: 'current'));
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'طلب #${list[index].id}',
                                              style: TextStyle(
                                                  color: AppTheme.mainColor,
                                                  fontSize: 17.sp,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(
                                              list[index].date,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color:
                                                  AppTheme.mainColorText),
                                            ),
                                            Row(
                                              children: [
                                                ...List.generate(
                                                  list[index].products.length < 3 ?
                                                  list[index].products.length:3, (i) =>
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
                                                        child: AppImage(list[index].products[i].url))
                                                  ),
                                                ), ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                list[index].products.length <= 3
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
                                                     '+${list[index].products.length-3}',
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
                                          children: [
                                            Container(
                                              width: 70.w,
                                              height: 23.h,
                                              decoration: BoxDecoration(
                                                  color: list[index].status=="in_way"
                                                      ? Color(0xFFE6F5F0)
                                                      : list[index].status== "pending"
                                                      ?AppTheme.thirdColor
                                                      : list[index].status== "canceled"
                                                      ?AppTheme.mainRedColor
                                                      :Colors.black,
                                                  borderRadius:
                                                  BorderRadius.circular(10.r)),
                                              child: Center(
                                                child: Text(
                                                  list[index].status,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: list[index].status=="in_way"
                                                          ? Color(0xFF2D9E78)
                                                          :list[index].status== "pending"
                                                          ?AppTheme.mainColor
                                                          : list[index].status== "canceled"
                                                          ?Colors.red
                                                          :Colors.white
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              '${list[index].orderPrice} ر.س',
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: AppTheme.mainColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 20.h,
                                    ),
                                itemCount: list.length),
                          );
                        } else if (state is ClientOrderFailedState) {
                          return AppFailed(msg: state.msg);
                        } else {
                          return AppLoading();
                        }
                      },
                    ),
                  ],
                ))));
  }
}

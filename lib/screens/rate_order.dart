import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:thimar/core/design/res/app_input.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import '../core/design/res/app_image.dart';
import '../core/design/res/appbar.dart';
import '../features/about_order/bloc.dart';
import '../features/rate_order/bloc.dart';
import '../core/logic/app_theme.dart';


class RateOrderView extends StatefulWidget {
  final ProductModel products;
  const RateOrderView({Key? key, required this.products}) : super(key: key);

  @override
  State<RateOrderView> createState() => _RateOrderViewState();
}

class _RateOrderViewState extends State<RateOrderView> {
  final bloc = KiwiContainer().resolve<AddRateBloc>();
  List<TextEditingController>? controllers ;

  double rate=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70.h),
        child: CustomAppBar(title: 'تقييم المنتجات'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      controllers = List.generate(widget.products.products.length, (index) => TextEditingController());
                      return  Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 64.h,
                                  width: 75.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(11.r)),
                                  child: AppImage(
                                    widget.products.products[index].url,
                                    w: 80.w,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.products.products[index].name,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.mainColor),
                                    ),
                                    Text(
                                      'السعر / 1كجم',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF808080)),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${widget.products.orderPrice}  ر٫س",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                              color: AppTheme.mainColor),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          "${widget.products.priceBeforeDiscount} ر٫س",
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppTheme.mainColor,
                                            decoration:
                                            TextDecoration.lineThrough,
                                            decorationColor:
                                            AppTheme.mainColor,
                                            decorationThickness: 2,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            RatingBar.builder(
                                initialRating: rate,
                                direction: Axis.horizontal,
                                itemSize: 20,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  rating=rate;
                                  print(rating);
                                }),
                            SizedBox(
                              height: 16.h,
                            ),
                            AppInput(
                              label: 'تعليق المنتج',
                              minLine: 4,
                              controller:controllers![index],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ]);

                    } ,  separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                    itemCount: widget.products.products.length),
                BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if(state is AddRateLoadingState){
                      return AppLoading();
                    }else{
                      return AppButton(
                        text: 'تقييم',
                        onTap: () {
                          bloc.add(AddRateStartEvents(

                              ProductId: widget.products.id,
                              comment:bloc.commentController.text,
                              value: rate));
                        },
                        height: 60.h,
                        width: 343.w,
                      );
                    }

                  },
                )
              ],
            )),
      ),
    );
  }
}

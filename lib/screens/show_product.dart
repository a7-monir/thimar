import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_image.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:thimar/helper/toast.dart';


import '../features/add_to_cart/bloc.dart';
import '../features/show_product/bloc.dart';
import '../helper/custom_text.dart';
import 'cart/view.dart';
import 'home/widget/custom_get_products.dart';



class ShowProduct extends StatefulWidget {
  final num productsId;
  final String productsName;
  late bool isFavorite;

   ShowProduct(
      {super.key,
      required this.productsId,
      required this.productsName,
        required this.isFavorite});

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  final bloc = KiwiContainer().resolve<ProductBloc>();
  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>()
    ..add(AddToCartStartEvent());

  AddFavModel? favModel;
  ShowProductModel? showProductModel;

  @override
  void initState() {
    super.initState();
    bloc.add(ShowProductStartEvent(
      productsId: widget.productsId,
    ));
    bloc.add(GetProductRateStartEvent(productsId: widget.productsId));
  }

  int quantity = 1;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 55.h,
          leadingWidth: 50.w,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsetsDirectional.only(
                start: 16.w, top: 10.h, bottom: 10.h),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDDE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppImage(
                "assets/icons/icon_back_right.png",
                w: 20.w,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          actions: [
            BlocConsumer(
              bloc: bloc,
              listener: (context, state) {
               if(state is AddToFavoriteSuccessState){
                 widget.isFavorite=true;
               }else{
                 widget.isFavorite=false;
               }
              },
              builder: (context, state) {
                return Container(
                  height: 32.h,
                  width: 32.w,
                  margin: EdgeInsetsDirectional.only(
                    end: 16.w,
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EDDE),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if(widget.isFavorite==false){
                        bloc.add(AddToFavoritesStartEvent(productsId: widget.productsId));
                      }else{
                        bloc.add(RemoveFromFavoritesStartEvent(productsId: widget.productsId));
                      }
                      Toast.show(bloc.showProductModel!.message, context);
                    },
                    child: widget.isFavorite == false
                        ? Icon(
                            Icons.favorite_border_outlined,
                            color: AppTheme.mainColor,
                            size: 20.w,
                          )
                        : Icon(
                            Icons.favorite,
                            color: AppTheme.mainColor,
                            size: 20.w,
                          ),
                  ),
                );
              },
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous != current && current is ShowProductLoadingState ||
              current is ShowProductSuccessState ||
              current is ShowProductFailedState,
          builder: (context, state) {
            if (state is ShowProductLoadingState) {
              return AppLoading();
            } else if (state is ShowProductSuccessState) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 244.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                          child: Stack(
                            children: [
                              Swiper(
                                itemBuilder: (BuildContext context, index) {
                                  return AppImage(
                                    bloc.showProductModel!.data.images[index]
                                        .url,
                                    w: MediaQuery.of(context).size.width.w,
                                    h: MediaQuery.of(context).size.height.h,
                                    fit: BoxFit.cover,
                                  );
                                },
                                autoplay: true,
                                itemCount:
                                    bloc.showProductModel!.data.images.length,
                                scrollDirection: Axis.horizontal,
                                pagination: SwiperPagination(
                                  alignment: Alignment.bottomCenter,
                                  builder: DotSwiperPaginationBuilder(
                                    color: Colors.white.withOpacity(0.5),
                                    activeColor: Colors.white,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 90.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "طماطم",
                                  widget.productsName,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.mainColor),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "السعر / ${bloc.showProductModel!.data.unit.name}",
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Color(0xFF808080)),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${(bloc.showProductModel!.data.discount * 100).toInt()}%",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFFF0000)),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      "${bloc.showProductModel!.data.price} ر٫س",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.mainColor),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      "${bloc.showProductModel!.data.priceBeforeDiscount} ر٫س",
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppTheme.mainColor,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppTheme.mainColor,
                                        decorationThickness: 4,
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  width: 109.w,
                                  height: 39.h,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8EFE0),
                                    borderRadius: BorderRadius.circular(9.r),
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          quantity++;
                                          isSelected = !isSelected;
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 29.w,
                                          height: 29.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: AppTheme.mainColor,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w900,
                                            color: AppTheme.mainColor),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          if (quantity > 1) {
                                            quantity--;
                                          } else if (quantity <= 1) {
                                            isSelected = !isSelected;
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 29.w,
                                          height: 29.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          // trash_icon
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                            color: AppTheme.mainColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xFFE8EFE0),
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "كود المنتج",
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.mainColor),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              bloc.showProductModel!.data.code,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF808080)),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xFFE8EFE0),
                        height: 1.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "تفاصيل المنتج",
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.mainColor),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              bloc.showProductModel!.data.description,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF808080),
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "التقييمات",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.mainColor),
                                ),
                                const Spacer(),
                                Text(
                                  "عرض الكل",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppTheme.mainColor),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            if (bloc.productRateModel != null)
                              SizedBox(
                                height: 120.h,
                                child: ListView.builder(
                                  itemCount: bloc.productRateModel!.list.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 211, 208, 208)
                                                  .withOpacity(0.5),
                                              spreadRadius: -7,
                                              blurRadius: 20,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Spacer(),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        bloc
                                                            .productRateModel!
                                                            .list[index]
                                                            .clientName,
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Color(
                                                                0xFF333333)),
                                                      ),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      RatingBar.builder(
                                                          maxRating: 1,
                                                          minRating: 5,
                                                          ignoreGestures: true,
                                                          initialRating: bloc
                                                              .productRateModel!
                                                              .list[index]
                                                              .value
                                                              .toDouble(),
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemSize: 15,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            print(rating);
                                                          }),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    bloc.productRateModel!
                                                        .list[index].comment,
                                                    softWrap: false,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: Color(0xFF333333),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            CircleAvatar(
                                              radius: (25.r),
                                              backgroundColor:
                                                  Colors.white.withOpacity(0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(14.r),
                                                child: AppImage(bloc
                                                    .productRateModel!
                                                    .list[index]
                                                    .clientImage),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomOnlyTitle(
                              title: "منتجات مشابهة",
                              color: AppTheme.mainColor,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              child: GetProducts(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ShowProductFailedState) {
              return AppFailed(
                msg: state.error,
              );
            } else {
              return AppLoading();
            }
          },
        ),
        bottomNavigationBar: AnimatedSwitcher(
          duration: Duration(seconds: 2),
          child: bloc.showProductModel == null
              ? SizedBox.shrink()
              : BlocBuilder(
                  bloc: addToCartBloc,
                  builder: (context, state) {
                    return Container(
                      height: 60.h,
                      color: AppTheme.mainColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                addToCartBloc.productId =
                                    bloc.showProductModel!.data.id;
                                addToCartBloc.add(AddToCartStartEvent());
                                Toast.show("تم الاضافة بنجاح", context);
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(38.r),
                                      topRight: Radius.circular(38.r),
                                    ),
                                  ),
                                  context: context,
                                  builder: (_) {
                                    return FractionallySizedBox(
                                      heightFactor: 0.3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.r),
                                          topRight: Radius.circular(30.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 25.w,
                                            vertical: 20.h,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 16.w,
                                                    height: 16.h,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFE8EFE0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                    ),
                                                    child: AppImage(
                                                      'assets/icons/check.png',
                                                      w: 11.w,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    "تم إضافة المنتج بنجاح",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            AppTheme.mainColor),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 60.w,
                                                      height: 60.h,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFE8EFE0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11.r),
                                                      ),
                                                      child: AppImage(
                                                        bloc.showProductModel!
                                                            .data.mainImage,
                                                        w: 50.w,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 14.w,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            widget.productsName,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: AppTheme
                                                                    .mainColor),
                                                          ),
                                                          SizedBox(
                                                            height: 3.h,
                                                          ),
                                                          Text(
                                                            'الكمية:${quantity}',
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Color(
                                                                    0xFF808080)),
                                                          ),
                                                          SizedBox(
                                                            height: 3.h,
                                                          ),
                                                          Text(
                                                            " ${bloc.showProductModel!.data.price * quantity}ر٫س",
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: AppTheme
                                                                    .mainColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                color: Color(0xFFE8EFE0),
                                                height: 1.0,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: AppButton(
                                                        text:
                                                            "التحويل إلى السلة",
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      CartView(
                                                                          quantity:
                                                                              quantity)));
                                                        },
                                                        height: 45.h,
                                                        fontSize: 12.w,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: AppButton(
                                                        text: "تصفح العروض",
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        height: 45.h,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 35.w,
                                      height: 35.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: const Color(0xFF6AA431),
                                      ),
                                      child: AppImage(
                                        'assets/icons/shopping.png',
                                        w: 16.w,
                                      )),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Text(
                                    "إضافة إلي السلة",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${bloc.showProductModel!.data.price * quantity}.ر٫س",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}

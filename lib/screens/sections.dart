import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_image.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/helper/helper_methods.dart';
import '../../constant/app_button.dart';
import '../../helper/app_theme.dart';
import '../constant/appbar.dart';
import '../features/add_to_cart/bloc.dart';
import '../features/sections/bloc.dart';
import '../helper/toast.dart';
import 'home/widget/search.dart';

import 'show_product.dart';

class SectionsView extends StatefulWidget {
  final categoryId;
  final categoryName;

  const SectionsView(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  final bloc = KiwiContainer().resolve<CategoriesProductBloc>();
  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>()
    ..add(AddToCartStartEvent());

  @override
  void initState() {
    bloc.add(CategoriesProductStartEvent(
      productsId: widget.categoryId,
    ));
    super.initState();
  }

  double start = 0.0;
  double end = 100.0;
  List<String> type = ["1", "0"];
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(title: widget.categoryName),
      ),
      body: BlocBuilder(
        bloc: bloc,
        // buildWhen: (previous, current) =>  current is CategoriesProductLoadingState
        // || current is CategoriesProductSuccessState || current is CategoriesProductFailedState,
        builder: (context, state) {
          if (state is CategoriesProductLoadingState) {
            return AppLoading();
          } else if (state is CategoriesProductSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                          color: AppTheme.mainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            width: 0.2.w,
                            color: const Color(0xFFE8EFE0),
                          )),
                      child: TextFormField(
                        onTap: (){
                          navigateTo(SearchView());
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ابحث عن ما تريد',
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: Color(0xffB9C9A8)),
                            prefixIcon: AppImage('assets/icons/search.png'),
                            suffixIcon: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(38.r),
                                      topRight: Radius.circular(38.r),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return DraggableScrollableSheet(
                                          initialChildSize: 0.55,
                                          maxChildSize: 0.55,
                                          minChildSize: 0.55,
                                          expand: false,
                                          builder: (context, scrollController) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 20.h,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "تصفية",
                                                      style: TextStyle(
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: AppTheme
                                                              .mainColor),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Color(0xFFF6F6F6),
                                                    height: 1.0,
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Text(
                                                    "السعر",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  RangeSlider(
                                                    values:
                                                        RangeValues(start, end),
                                                    min: 0,
                                                    max: 200,
                                                    divisions: 100,
                                                    activeColor:
                                                        AppTheme.mainColor,
                                                    inactiveColor:
                                                        Color(0xffDCE2D5),
                                                    labels: RangeLabels(
                                                        start.toString(),
                                                        end.toString()),
                                                    onChanged:
                                                        (RangeValues values) {
                                                      setState(() {
                                                        start = values.start;
                                                        end = values.end;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  const Divider(
                                                    color: Color(0xFFF6F6F6),
                                                    height: 1.0,
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Text(
                                                    "الترتيب",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          type.last = '0';
                                                          if (type.last ==
                                                              '0') {
                                                            isActive = true;
                                                          } else {
                                                            isActive = false;
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 23.w,
                                                          height: 23.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: type.last ==
                                                                    '0'
                                                                ? AppTheme
                                                                    .mainColor
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.r),
                                                            border: Border.all(
                                                              width: 0.5.w,
                                                              color: const Color(
                                                                  0xFFECECEC),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      Text(
                                                        "من السعر الأقل للأعلي",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: AppTheme
                                                                .mainColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          type.last = '1';
                                                          if (type.last ==
                                                              '1') {
                                                            isActive = true;
                                                          } else {
                                                            isActive == false;
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: 23.w,
                                                          height: 23.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: type.last ==
                                                                    '1'
                                                                ? AppTheme
                                                                    .mainColor
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            border: Border.all(
                                                              width: 0.5,
                                                              color: const Color(
                                                                  0xFFECECEC),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.h,
                                                      ),
                                                      Text(
                                                        "من السعر الأعلى للأقل",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: AppTheme
                                                                .mainColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  const Divider(
                                                    color: Color(0xFFF6F6F6),
                                                    height: 1.0,
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  AppButton(
                                                    text: "تطبيق",
                                                    onTap: () {
                                                      bloc.add(
                                                          CategoriesProductStartEvent(
                                                              productsId: widget
                                                                  .categoryId,
                                                              min: start,
                                                              max: end));

                                                      // bloc.add(CategoriesProductStartEvent(ProductsId:widget.categoryId));
                                                      //  setState((){});
                                                    },
                                                    height: 60.h,
                                                    width: 343.w,
                                                    fontSize: 17.sp,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppTheme.mainColor,
                                ),
                                child: AppImage('assets/icons/setting.png'),
                              ),
                            )),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 330,
                      crossAxisSpacing: 16.h,
                    ),
                    itemCount: bloc.model!.list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            navigateTo(ShowProduct(
                              productsId: bloc.model!.list[index].id,
                              productsName: bloc.model!.list[index].title,
                              isFavorite: bloc.model!.list[index].isFavorite,
                            ));
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.all(11.r),
                            margin: EdgeInsets.only(bottom: 16.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.2),
                                      offset: Offset(0, 2),
                                      blurRadius: 11.r)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(11.r),
                                  child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Container(
                                        height: 117.h,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11.r),
                                          color: const Color(0xFFFFFCF7),
                                        ),
                                        child: AppImage( bloc.model!.list[index].mainImage,fit: BoxFit.fill,w:double.infinity,),

                                      ),
                                      if (bloc.model!.list[index].discount !=
                                          null)
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 3.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                              bottomStart:
                                                  Radius.circular(11.r),
                                            ),
                                            color: AppTheme.mainColor,
                                          ),
                                          child: Text(
                                            '${(bloc.model!.list[index].discount * 100).toInt()}%',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      bloc.model!.list[index].title,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.mainColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "السعر / ${bloc.model!.list[index].unit.name}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF808080)),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${bloc.model!.list[index].price} ر٫س",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                              color: AppTheme.mainColor),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        if (bloc.model!.list[index]
                                                .priceBeforeDiscount != null)
                                          Text(
                                            "${bloc.model!.list[index].priceBeforeDiscount} ر٫س",
                                            // overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppTheme.mainColor,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  AppTheme.mainColor,
                                              decorationThickness: 4,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        Spacer(),
                                        data[index]['isSelected'] == false
                                            ? InkWell(
                                                onTap: () {
                                                  data[index]['isSelected'] =
                                                      !data[index]
                                                          ['isSelected'];
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 30.w,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.mainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (data[index]
                                                              ['quantity'] >
                                                          1) {
                                                        data[index]
                                                            ['quantity']--;
                                                      } else if (data[index]
                                                              ['quantity'] <=
                                                          1) {
                                                        data[index]
                                                                ['isSelected'] =
                                                            !data[index]
                                                                ['isSelected'];
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: 16.w,
                                                      height: 16.w,
                                                      decoration: BoxDecoration(
                                                        color: data[index][
                                                                    'quantity'] >
                                                                1
                                                            ? AppTheme.mainColor
                                                            : const Color(
                                                                0xFFFFFCF7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.r),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      // trash_icon
                                                      child: data[index]
                                                                  ['quantity'] >
                                                              1
                                                          ? const Icon(
                                                              Icons.remove,
                                                              size: 10,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : AppImage(
                                                              'assets/icons/trash.png',
                                                              w: 16.w,
                                                            ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(data[index]['quantity']
                                                      .toString()),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      data[index]['quantity']++;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: 16.w,
                                                      height: 16.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppTheme.mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.r),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons.add,
                                                        size: 10,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    BlocBuilder(
                                      bloc: addToCartBloc,
                                      builder: (context, state) {
                                        return AppButton(
                                          text: "أضف للسلة",
                                          onTap: () {
                                            addToCartBloc.productId =
                                                bloc.model!.list[index].id;
                                            addToCartBloc
                                                .add(AddToCartStartEvent());
                                            Toast.show(
                                                "تم الاضافة بنجاح", context);
                                          },
                                          height: 33.h,
                                          fontSize: 11.sp,
                                          width: 115.w,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                  )
                ],
              ),
            );
          } else if ((state is CategoriesProductFailedState)) {
            return AppFailed(msg: '${state.error}');
          } else {
            return AppLoading();
          }
        },
      ),
    );
  }

  final List<Map> data =
      List.generate(10, (index) => {'quantity': 0, 'isSelected': false});
}
//git status
//git add .
//git commit -m "login"
//git push
//

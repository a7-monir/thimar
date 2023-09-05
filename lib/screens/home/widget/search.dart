import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_failed.dart';
import '../../../../constant/app_button.dart';
import '../../../../constant/app_image.dart';
import '../../../../constant/app_loading.dart';
import '../../../../features/add_to_cart/bloc.dart';
import '../../../../features/search/bloc.dart';
import '../../../../helper/app_theme.dart';
import '../../../../helper/helper_methods.dart';
import '../../../../helper/toast.dart';
import '../../show_product.dart';


class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}


class _SearchViewState extends State<SearchView> {
  final bloc = KiwiContainer().resolve<SearchBloc>();
  final addToCartBloc = KiwiContainer().resolve<AddToCartBloc>()
    ..add(AddToCartStartEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.mainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            width: 0.2.w,
                            color: const Color(0xFFF9FBF7),
                          ),
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          onChanged: (value){
                            bloc.add(SearchStartEvent(value));

                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ابحث عن ما تريد',
                            prefixIcon: AppImage('assets/icons/search.png'),

                          ),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_outlined,
                        textDirection: TextDirection.ltr,
                        color: AppTheme.mainColor,
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is SearchLoadingState){
                    return AppLoading();
                  }else if(state is SearchSuccessState){
                    return  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 330,
                        crossAxisSpacing: 16.h,
                      ),
                      itemCount: bloc.model!.list.searchResult.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              navigateTo(ShowProduct(
                                productsId: bloc.model!.list.searchResult[index].id,
                                productsName: bloc.model!.list.searchResult[index].title,
                                isFavorite: bloc.model!.list.searchResult[index].isFavorite,
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
                                        offset: Offset(0,2),
                                        blurRadius: 11.r
                                    )
                                  ]
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:BorderRadius.circular(11.r),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Container(
                                          height: 117.h,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(11.r),
                                            color: const Color(0xFFFFFCF7),
                                          ),
                                          child: Image.network(
                                            bloc.model!.list.searchResult[index].mainImage,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                            // width: 107.w,
                                          ),
                                        ),
                                        if (bloc.model!.list.searchResult[index].discount != null)
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            padding:EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h) ,
                                            decoration: BoxDecoration(
                                              borderRadius:  BorderRadiusDirectional.only(
                                                bottomStart : Radius.circular(11.r),
                                              ),
                                              color: AppTheme.mainColor,
                                            ),
                                            child: Text(
                                              '${(bloc.model!.list.searchResult[index].discount*100).toInt()}%' ,
                                              style:  TextStyle(fontSize: 14.sp,
                                                  fontWeight: FontWeight.w900, color: Colors.white),
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
                                        bloc.model!.list.searchResult[index].title,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w900,
                                            color: AppTheme.mainColor),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "السعر / ${bloc.model!.list.searchResult[index].unit.name}",
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
                                            "${bloc.model!.list.searchResult[index].price} ر٫س",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: AppTheme.mainColor),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          if (bloc.model!.list.searchResult[index].priceBeforeDiscount != null)
                                            Text(
                                              "${bloc.model!.list.searchResult[index].priceBeforeDiscount} ر٫س",
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppTheme.mainColor,
                                                decoration: TextDecoration.lineThrough,
                                                decorationColor: AppTheme.mainColor,
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
                                                  bloc.model!.list.searchResult[index].id;
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
                    );
                  }else if(state is SearchFailedState ){
                    return AppFailed(msg: state.error);
                  }else {
                    return SizedBox(height: 10.h,);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  final List<Map> data =
  List.generate(10, (index) => {'quantity': 0, 'isSelected': false});
}

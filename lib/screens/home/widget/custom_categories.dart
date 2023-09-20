import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import '../../../../features/categories/bloc.dart';
import '../../../core/logic/helper_methods.dart';
import '../../sections.dart';



class CustomCategory extends StatefulWidget {
  const CustomCategory({Key? key}) : super(key: key);

  @override
  State<CustomCategory> createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  AnimationController? animateController;

  final bloc = KiwiContainer().resolve<CategoriesBloc>()..add(CategoriesStartEvent());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is CategoriesFailedState) {
          return Center(
            child: Text(state.msg),
          );
        } else if (state is CategoriesSuccessState) {
          var list = state.model.list;
          return GridView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              //  maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            scrollDirection: Axis.horizontal,
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  debugPrint("${list[index].id}");
                  navigateTo( SectionsView(
                    categoryId: list[index].id,
                    categoryName: list[index].name,

                  ),);
                },
                child: AnimationConfiguration.staggeredList(
                  position: index.bitLength,
                  duration: const Duration(seconds: 1),
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(
                                  (math.Random().nextDouble() * 0x32EFCC7C)
                                      .toInt())
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            alignment: Alignment.center,
                            width: 76.w,
                            height: 76.h,
                            padding: EdgeInsets.all(15.r),
                            child: Image.network(
                              // 'assets/icons/fruits_icon.png',
                              list[index].media,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            list[index].name,
                            style:  TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
       else if (state is CategoriesLoadingState) {
          return AppLoading();
        }else {
          return Text("Something Wrong");
        }
        },
    );
  }
}

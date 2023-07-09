import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../mutual_bloc/bloc_categories/bloc.dart';
import '../../../../mutual_bloc/bloc_categories/events.dart';
import '../../../../mutual_bloc/bloc_categories/states.dart';
import '../../sections/view.dart';


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
        if (state is CategoriesLoadingState) {
          return Center(
              child: Container(
                  width: 30,
                  height: 30,
                  child: const CircularProgressIndicator()));
        }
        else if (state is CategoriesSuccessState) {
          var data = bloc.categoriesModel!.data;
          return GridView.builder(
            itemCount: bloc.categoriesModel!.data.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              //  maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  debugPrint("${data[index].id}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionsView(
                        categoryId: data[index].id,
                        categoryName: data[index].name,
                      ),
                    ),
                  );
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            width: 76.w,
                            height: 76.h,
                            padding: const EdgeInsets.all(15),
                            child: Image.network(
                              // 'assets/icons/fruits_icon.png',
                              data[index].media,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data[index].name,
                            style: const TextStyle(
                              fontSize: 12,
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
        else if (state is CategoriesFailedState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Center(
            child: Container(
              width: 30,
              height: 30,
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        }
      },
    );
  }
}

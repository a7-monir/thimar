import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_loading.dart';

import '../../../../features/slider/bloc.dart';


class SliderApp extends StatefulWidget {
  const SliderApp({Key? key}) : super(key: key);

  @override
  State<SliderApp> createState() => _SliderAppState();
}

class _SliderAppState extends State<SliderApp> {

  final bloc = KiwiContainer().resolve<SliderBloc>()..add(SliderStartEvent());

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder(
      bloc: bloc,
        builder: (context, state) {
          if(state is SliderLoadingState){
            return AppLoading();
          }else if(state is SliderSuccessState) {
            var list = state.model.list;
            return Swiper(
              itemBuilder: (context, index) {
                return Image.network(
                    list[index].media,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width.w,
                  height: MediaQuery.of(context).size.height.h,
                );
              },
              autoplay: true,
              itemCount:list.length,
              scrollDirection: Axis.horizontal,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  color: Colors.white.withOpacity(0.5),
                  activeColor: Colors.white,
                ),
                margin:  EdgeInsets.only(
                  top: 90.h,
                ),
              ),
               );
          } else if(state is SliderFailedState){
            return Center(
              child: Text(state.msg),
            );
          }else {
            return AppLoading();
          }
        },);
  }
}

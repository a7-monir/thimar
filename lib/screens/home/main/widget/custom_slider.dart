import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import 'package:thimar/mutual_bloc/bloc_slider/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_slider/events.dart';

import '../../../../mutual_bloc/bloc_slider/states.dart';

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
            return Center(
                child: Container(
                width: 30,
                height: 30,
                child: const CircularProgressIndicator()));
          }else if(state is SliderSuccessState) {
            return Swiper(
              itemBuilder: (context, index) {
                return Image.network(
                    bloc.sliderModel!.data[index].media,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width.w,
                  height: MediaQuery.of(context).size.height.h,
                );
              },
              autoplay: true,
              itemCount: bloc.sliderModel!.data.length,
              scrollDirection: Axis.horizontal,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  color: Colors.white.withOpacity(0.5),
                  activeColor: Colors.white,
                ),
                margin: const EdgeInsets.only(
                  top: 90,
                ),
              ),
               );
          } else if(state is SliderFailedState){
            return Center(
              child: Text(state.error),
            );
          }else {
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
        },);
  }
}

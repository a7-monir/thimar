import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_logo.dart';
import '../core/design/res/app_failed.dart';
import '../core/design/res/app_loading.dart';
import '../core/design/res/appbar.dart';
import '../features/about_us/bloc.dart';


class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {

  final bloc= KiwiContainer().resolve<AboutBloc>()..add(AboutStartEvent());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(title: 'عن التطبيق'),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if(state is AboutLoadingState){
            return AppLoading();
          }else if(state is AboutSuccessState){
            return Column(
              children: [
                AppLogo(),
                Html(data: state.model.model.about,)
              ],
            );
          }else if(state is AboutFailedState){
            return AppFailed(msg: state.error);
          }else{
            return AppLoading();
          }

        },

      ),
    );
  }
}

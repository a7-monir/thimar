import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/constant/appbar.dart';

import '../features/policy/bloc.dart';


class PolicyView extends StatefulWidget {
  PolicyView({Key? key}) : super(key: key);

  @override
  State<PolicyView> createState() => _PolicyViewState();
}

class _PolicyViewState extends State<PolicyView> {
  final bloc= KiwiContainer().resolve<PolicyBloc>()..add(PolicyStartEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomAppBar(title: 'سياسة الخصوصية'),),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if(state is PolicyLoadingState){
            return AppLoading();
          }else if(state is PolicySuccessState){
            return Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              child: Html(data: bloc.model!.list.policy,
              ),
            );
          }else if(state is PolicyFailedState){
            return AppFailed(msg: state.error);
          }else{
            return AppLoading();
          }

        },
      ),
    );
  }
}

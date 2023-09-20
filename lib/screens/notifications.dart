import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import '../core/design/res/app_failed.dart';
import '../core/design/res/appbar.dart';
import '../core/design/res/notification_content.dart';
import '../features/notifications/bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final bloc = KiwiContainer().resolve<NotificationsBloc>()..add(NotificationsStartEvent());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomAppBar(title: 'الإشعارات'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if(state is NotificationsLoadingState){
                return AppLoading();
              }else if (state is NotificationsSuccessState){
                final list =state.model.data.list;
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        NotificationsContent(
                            icon:  list[index].image,
                            title:  list[index].title,
                            hint:  list[index].body,
                            time:  list[index].createdAt),
                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                    itemCount:  list.length);


              }else if (state is NotificationsFailedState){
                return AppFailed(msg: state.msg);
              } return SizedBox(height: 10,);

            },
          ),
        ),
      ),
    );
  }
}

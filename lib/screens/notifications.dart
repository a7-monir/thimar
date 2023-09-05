import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_loading.dart';
import '../constant/appbar.dart';
import '../constant/notification_content.dart';
import '../features/get_notifications/bloc.dart';

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
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        NotificationsContent(
                            icon: bloc.model!.list.list[index].image,
                            title: bloc.model!.list.list[index].title,
                            hint: bloc.model!.list.list[index].body,
                            time: bloc.model!.list.list[index].createdAt),
                    separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                    itemCount: bloc.model!.list.list.length);

                //   Column(
                //   children: [
                //     const NotificationsContent(
                //         icon: 'assets/icons/note.png',
                //         title: 'تم قبول طلبك وجاري تحضيره الأن',
                //         hint: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                //         time: 'منذ ساعتان'),
                //
                //
                //
                //   ],
                // );
              }else if (state is NotificationsFailedState){
                return AppFailed(msg: state.error);
              } return SizedBox(height: 10,);

            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/constant/appbar.dart';
import '../features/faqs/bloc.dart';

class FaqsView extends StatefulWidget {
  const FaqsView({Key? key}) : super(key: key);

  @override
  State<FaqsView> createState() => _FaqsViewState();
}

class _FaqsViewState extends State<FaqsView> {
  final bloc = KiwiContainer().resolve<FaqsBloc>()..add(FaqsStartEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomAppBar(title: 'أسئلة متكررة'),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if(state is FaqsLoadingState){
            return AppLoading();
          }
          else if (state is FaqsSuccessState){
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 26.w, left: 26.w),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>ExpansionTile(
                          title:Text(bloc.model!.list[index].question),
                          children: [
                            Text(bloc.model!.list[index].answer),
                          ],
                        ),


                        // AppQuestions(
                        // title: 'كل ما تريد معرفته عن أكواد الخصم/ الكوبونات'),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 30.h,
                        ),
                        itemCount: bloc.model!.list.length),
                  ],
                ),
              ),
            );
          }
          else if(state is FaqsFailedState){
            return AppFailed(msg: state.error);
          }
          else{return AppLoading();}

        },
      ),
    );
  }
}

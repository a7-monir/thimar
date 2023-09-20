import 'package:easy_localization/easy_localization.dart'as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../core/logic/app_theme.dart';
import '../../core/design/res/app_failed.dart';
import '../../features/login/bloc.dart';
import '../../features/register/bloc.dart';



class ChooseCityDialog extends StatefulWidget {
  final String? selectedCityId;

  const ChooseCityDialog({Key? key, this.selectedCityId}) : super(key: key);

  @override
  State<ChooseCityDialog> createState() => _ChooseCityDialogState();
}

class _ChooseCityDialogState extends State<ChooseCityDialog> {
  final bloc = KiwiContainer().resolve<RegisterBloc>()
      ..add(RegisterGetCitiesStartEvents());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 317.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only
            (topRight: Radius.circular(50), topLeft: Radius.circular(50),),

        ),
        child: Column(
          children: [
            SizedBox(height: 15.h,),
            Text(
              LocaleKeys.Auth_City.tr(), style: TextStyle(
                color: AppTheme.mainColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold
            ),),
            const Divider(),
            BlocBuilder(
              bloc:bloc,
              builder: (context, state) {
                if(state is RegisterGetCitiesLoadingState){
                  return AppLoading();
                }
                else if (state is RegisterGetCitiesSuccessState){
                  List<City> cities = state.model.list!;
                  return Flexible(
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context,cities[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: cities[index].id==widget.selectedCityId
                                ?AppTheme.mainColor
                                :Colors.transparent,
                          ),

                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Center(
                            child: Text(
                              cities[index].name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: cities[index].id==widget.selectedCityId
                                  ?Colors.white
                                  :AppTheme.mainColor,
                            ),
                            ),

                          ),
                        ),
                      ),
                      itemCount: cities.length,
                      separatorBuilder: (context, index) =>
                          Divider(),
                    ),
                  );
                } else if(state is RegisterGetCitiesFailState){
                  return
                  AppFailed(msg: state.msg);

                }else {
                  return const Text("Check states");}


              },
            )
          ],
        ),
      ),
    );
  }
}

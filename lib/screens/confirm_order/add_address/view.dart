import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/helper/helper_methods.dart';
import 'package:thimar/screens/add_address.dart';
import '../../../../constant/app_image.dart';
import '../../../../features/address/bloc.dart';
import '../../../../helper/app_theme.dart';


class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final bloc = KiwiContainer().resolve<AddressBloc>()
    ..add(GetAddressStartEvent());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 413.h,
        width: 376.w,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'العناوين',
                style: TextStyle(
                    color: AppTheme.mainColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if(state is GetAddressLoadingState){
                      return AppLoading();
                    }else if (state is GetAddressSuccessState){
                      return ListView.separated(
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context,[
                                    bloc.model!.list[index].type,
                                    bloc.model!.list[index].location,
                                    bloc.model!.list[index].id
                                  ]);
                                },
                                child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.mainColor),
                                borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bloc.model!.list[index].type,
                                            style: TextStyle(
                                                color: AppTheme.mainColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('العنوان: ${bloc.model!.list[index].location}',
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: AppTheme.mainColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            bloc.model!.list[index].description,
                                            style: TextStyle(
                                              color: AppTheme.mainColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            bloc.model!.list[index].phone,
                                            style: TextStyle(
                                              color: AppTheme.mainColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      height: 24.h,
                                      width: 24.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8.r),
                                          color: const Color(0xFFFFE3E3)),
                                      child: AppImage('assets/icons/trash.png'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 24.h,
                                      width: 24.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8.r),
                                          color: AppTheme.thirdColor),
                                      child: AppImage('assets/icons/edit.png'),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                          itemCount: bloc.model!.list.length);
                    }else if (state is GetAddressFailedState) {
                      return AppFailed(msg:state.error);
                    }else{return AppLoading();}
                  },
                ),
              ),
              SizedBox(height: 10.h,),
              DottedBorder(
                color: AppTheme.mainColor,
                borderType: BorderType.RRect,
                dashPattern: const [6],
                radius: Radius.circular(15.r),
                child: AppButton(
                  text: 'إضافة عنوان جديد',
                  onTap: () {
                    navigateTo(AddAddressView());
                  },
                  height: 54.h,
                  width: 342.w,
                  type: btnType.dottedBorder,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart'as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/generated/locale_keys.g.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/screens/auth/login/view.dart';
import '../../../constant/app_input.dart';
import '../../../helper/toast.dart';


import '../login/bloc/model.dart';
import '../verification/view.dart';
import 'bloc/bloc.dart';
import 'bloc/events.dart';
import 'bloc/states.dart';
import 'city/view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final bloc = KiwiContainer().resolve<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                Text(
                  LocaleKeys.Auth_welcome_again.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.mainColor,
                  ),
                ),
                Text(
                  LocaleKeys.Auth_You_can_log_in_now.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppTheme.maingreycolor,
                  ),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: bloc.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppCustomInput(
                        label:  LocaleKeys.Auth_user_name.tr(),
                        prefix: 'user.png',
                        obscureText: false,
                        controller: bloc.fullNameController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 69.w,
                              padding: EdgeInsets.only(
                                top: 10.h,
                                bottom: 5.h,
                                left: 10.w,
                                right: 10.w,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 0.5.w,
                                      color:AppTheme.maingreycolor)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                   Image.asset('assets/icons/ksa.png',width: 35.w,fit: BoxFit.fill,),
                                  Text(
                                    '+966',
                                    style: TextStyle(
                                        color: AppTheme.mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              )),
                           SizedBox(
                            width: 10.w,
                          ),
                           Expanded(
                              child: AppCustomInput(label: lang.tr(LocaleKeys.Auth_Mobile_number),
                                  prefix: 'phoneicon.png',
                                  textInputType: TextInputType.phone,
                                  controller: bloc.phoneController,
                                  obscureText: false),),
                        ],
                      ),
                      
                      SizedBox(
                        height: 10.h,
                      ),
                      StatefulBuilder(builder: (context,setState){
                        return InkWell(
                          child: AppCustomInput(
                            hint: lang.tr(LocaleKeys.Auth_City),
                            prefix: 'city.png',
                            obscureText: false,
                            isEnabled: false,
                            label: bloc.cityName,

                          ),
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(15.r),
                                      topStart: Radius.circular(15.r)),
                                ),
                                builder: (context) => ChooseCityDialog(
                                  selectedCityId: bloc.cityId,
                                )).then((value) {
                              if(value!=null){
                                var city =value as City;
                                bloc.cityId=city.id;
                                bloc.cityName=city.name;
                                 setState((){});

                              }
                            });
                          },

                        );
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                       AppCustomInput(
                        controller: bloc.passwordController,
                          label:  lang.tr(LocaleKeys.Auth_password),
                        prefix: 'lock.png',
                          obscureText: true,
                          textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppCustomInput(
                        controller: bloc.confirmationPasswordController,
                        label: lang.tr(LocaleKeys.Auth_password),
                        prefix: 'lock.png',
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BlocConsumer(
                        bloc:bloc,
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationView(
                                  phone: bloc.phoneController.text,
                                  fromForget: false,
                                ),
                              ),
                            );
                          } else if (state is RegisterFailState) {
                            Toast.show(state.error, context);
                          }
                        },
                        builder: (context, state) {
                          if(state is RegisterLoadingState){
                            return CircularProgressIndicator();
                          }else {
                            return AppButton(
                              text: lang.tr(LocaleKeys.Auth_Registration),
                              fontcolor: Colors.white,
                              ontap: () {
                                bloc.unfocus(context);
                                if(bloc.isDataVaild(context)){
                                  bloc.add(RegisterStartEvents());
                                }
                              },
                              height: 50.h,
                              width: 343.w,
                              fontsize: 15.sp,
                              color: AppTheme.mainColor,
                            );
                          }

  },
),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           LocaleKeys.Auth_You_dont_have_an_account.tr(),
                            style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 15.sp,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView(),));
                            },
                            child: Text(
                              LocaleKeys.Auth_Register_now.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: AppTheme.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),

        ),
      ),
    );
  }
}


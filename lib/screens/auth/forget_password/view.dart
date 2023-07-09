import 'package:easy_localization/easy_localization.dart'as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/generated/locale_keys.g.dart';
import 'package:thimar/screens/auth/forget_password/bloc/bloc.dart';
import 'package:thimar/screens/auth/forget_password/bloc/events.dart';
import 'package:thimar/screens/auth/forget_password/bloc/states.dart';
import 'package:thimar/screens/auth/login/view.dart';
import '../../../constant/app_input.dart';
import '../../../helper/app_theme.dart';
import '../../../helper/toast.dart';
import '../verification/view.dart';

class ForgetPasswordView extends StatefulWidget {

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final bloc = KiwiContainer().resolve<ForgetPasswordBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LocaleKeys.Auth_Forgot_your_password.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.mainColor,
                  ),
                ),
                Text(
                  'أدخل رقم الجوال المرتبط بحسابك',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppTheme.maingreycolor,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppTheme.maingreycolor, width: 0.5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/ksa.png',
                              width: 35,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              '+966',
                              style: TextStyle(
                                  color: AppTheme.mainColor, fontSize: 15.sp),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        flex: 5,
                        child: AppCustomInput(
                          label: lang.tr(LocaleKeys.Auth_Mobile_number,),
                          prefix: 'phoneicon.png',
                          textInputType: TextInputType.phone,
                          controller: bloc.phoneController,
                          obscureText: false,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if(state is ForgetPasswordSuccessState){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>VerificationView(
                              phone: bloc.phoneController.text,
                          fromForget:true ,
                          isActive: true,),));
                    }else if (state is ForgetPasswordFailState) {
                      Toast.show(state.error, context);
                    }
                  },
                  builder: (context, state) {
                    if(state is ForgetPasswordLoadingState){
                      return Center(
                          child: const CircularProgressIndicator());
                    }else{
                      return AppButton(
                        text: lang.tr(LocaleKeys.Auth_Confirm_mobile_number),
                        fontcolor: Colors.white,
                        ontap: () {
                         bloc.add(ForgetPasswordStartEvents(
                            phone: bloc.phoneController.text
                         ));
                        },
                        height: 60.h,
                        width: 343.w,
                        fontsize: 15.sp,
                        color: AppTheme.mainColor,
                      );
                    }

                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    LocaleKeys.Auth_Already_have_an_account.tr(),
                      style: TextStyle(
                        color: AppTheme.maingreycolor,
                        fontSize: 15.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()));
                      },
                      child: Text(
                        LocaleKeys.Auth_Register_now.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: AppTheme.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

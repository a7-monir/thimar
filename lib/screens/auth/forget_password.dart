import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';

import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/constant/app_logo.dart';
import 'package:thimar/generated/locale_keys.g.dart';
import 'package:thimar/helper/helper_methods.dart';

import 'package:thimar/screens/auth/login.dart';
import '../../constant/app_input.dart';
import '../../features/forget_password/bloc.dart';
import '../../helper/app_theme.dart';
import '../../helper/toast.dart';
import 'verification.dart';

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
                const AppLogo(),
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
                    color: AppTheme.mainGreyColor,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppInput(
                    inputType: InputType.phone,
                  label: lang.tr(
                    LocaleKeys.Auth_Mobile_number,
                  ),
                  prefix: 'assets/icons/phoneicon.png',
                  textInputType: TextInputType.phone,
                  controller: bloc.phoneController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccessState) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationView(
                              phone: bloc.phoneController.text,
                              fromForget: true,
                              isActive: true,
                            ),
                          ));
                    } else if (state is ForgetPasswordFailState) {
                      Toast.show(state.error, context);
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgetPasswordLoadingState) {
                      return AppLoading();
                    } else {
                      return AppButton(
                        text: lang.tr(LocaleKeys.Auth_Confirm_mobile_number),
                        onTap: () {
                          bloc.add(ForgetPasswordStartEvents(
                              phone: bloc.phoneController.text));
                        },
                        height: 60.h,
                        width: 343.w,
                      );
                    }
                  },
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.Auth_Already_have_an_account.tr(),
                      style: TextStyle(
                        color: AppTheme.mainColor,
                        fontSize: 15.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(LoginView());
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

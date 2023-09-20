import 'package:easy_localization/easy_localization.dart'as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import 'package:thimar/core/design/res/app_logo.dart';
import 'package:thimar/generated/locale_keys.g.dart';
import 'package:thimar/screens/auth/forget_password.dart';
import 'package:thimar/screens/auth/register.dart';
import 'package:thimar/screens/auth/verification.dart';

import '../../core/design/res/app_input.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/logic/toast.dart';
import '../../features/login/bloc.dart';
import '../../core/logic/app_theme.dart';
import '../main/view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final bloc = KiwiContainer().resolve<LoginBloc>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLogo(),
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
                    color: AppTheme.mainColorText,
                    fontSize: 16.sp,

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
                      AppInput(
                        inputType: InputType.phone,
                        label: lang.tr(LocaleKeys.Auth_Mobile_number),
                        prefix: 'assets/icons/phoneicon.png',
                        textInputType: TextInputType.number,
                        controller: bloc.phoneController,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return  lang.tr(LocaleKeys.Auth_validator_write_the_phone);
                          } else {
                            return null;
                          }
                        },

                      ),
                      AppInput(
                        label: lang.tr(LocaleKeys.Auth_password),
                        prefix: 'assets/icons/lock.png',
                        inputType: InputType.password,
                        controller: bloc.passwordController,
                        textInputType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return lang.tr(LocaleKeys.Auth_validator_No_password_was_typed);
                          } else {
                            return null;
                          }
                        },
                        onSubmit: (value){
                          print(bloc.phoneController.text);
                          print(bloc.passwordController.text);
                          bloc.add(LoginStartEvents(phone: bloc.phoneController.text,password: bloc.passwordController.text));
                        },
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            navigateTo(ForgetPasswordView());
                            },
                          child: Text(
                            LocaleKeys.Auth_Forgot_your_password.tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppTheme.mainColorText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocConsumer(
                        bloc: bloc,

                        listener: (context, state) {
                          if(state is LoginSuccessState){
                            navigateTo(MainView());


                          }else if (state is LoginFailState) {
                            if(state.statusCode==403){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationView(
                                  phone: bloc.phoneController.text,
                                  fromForget:false),));
                            } else{ Toast.show(state.msg, context);}

                          }
                        },


                        builder: (context, state) {
                          if (state is LoginLoadingState){
                            return AppLoading();

                          }else{
                            return AppButton(
                              text:lang.tr( LocaleKeys.Auth_sign_in),
                              onTap: () {
                                print(bloc.phoneController.text);
                                print(bloc.passwordController.text);
                                bloc.add(LoginStartEvents(
                                    phone: bloc.phoneController.text,
                                    password: bloc.passwordController.text));
                             //   Toast.show(bloc.model!.message, context);
                                },
                              height: 50.h,
                              width: 343.w,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lang.tr( LocaleKeys.Auth_You_dont_have_an_account),
                            style: TextStyle(
                                color: AppTheme.mainColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(width: 5.w,),

                          InkWell(
                            onTap: () {
                              navigateTo( RegisterView());
                              },
                            child: Text(
                              lang.tr( LocaleKeys.Auth_Register_now),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: AppTheme.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart'as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/generated/locale_keys.g.dart';
import 'package:thimar/helper/cache_helper.dart';
import 'package:thimar/screens/auth/forget_password/view.dart';
import 'package:thimar/screens/auth/login/bloc/events.dart';
import 'package:thimar/screens/auth/register/view.dart';
import 'package:thimar/screens/auth/verification/view.dart';
import 'package:thimar/screens/home/view.dart';
import '../../../constant/app_input.dart';
import '../../../helper/app_theme.dart';
import '../../../helper/toast.dart';
import 'bloc/bloc.dart';
import 'bloc/states.dart';

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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 69.w,
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 10,
                                right: 10,),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                      color: AppTheme.maingreycolor)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/ksa.png',
                                    width: 40.w,
                                    fit: BoxFit.fill,),
                                  Text(
                                    '+966',
                                    style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: AppCustomInput(
                              label: lang.tr(LocaleKeys.Auth_Mobile_number),
                              prefix: 'phoneicon.png',
                              textInputType: TextInputType.number,
                              obscureText: false,
                              controller: bloc.phoneController,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return  lang.tr(LocaleKeys.Auth_validator_write_the_phone);
                                } else {
                                  return null;
                                }
                              },

                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppCustomInput(
                        label: lang.tr(LocaleKeys.Auth_password),
                        prefix: 'lock.png',
                        obscureText: true,
                        controller: bloc.passwordController,
                        textInputType: TextInputType.visiblePassword,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => ForgetPasswordView(),));
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
                            if(CacheHelper.setFCMToken("token") != null){
                              Toast.show(bloc.model!.message, context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(),));
                            }else {
                              Toast.show(bloc.model!.message, context);}

                          }else if (state is LoginFailState) {
                            if(state.type==403){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationView(
                                  phone: bloc.phoneController.text,
                                  fromForget:false),));
                            } else{ Toast.show(state.error, context);}
                            // if(bloc.model!.data.isActive == false){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationView(phone: bloc.phoneController.text),));
                            //   Toast.show(state.error, context);
                            // }else{

                          //}

                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState){
                            return CircularProgressIndicator();
                          }else{
                            return AppButton(
                              text:lang.tr( LocaleKeys.Auth_sign_in),
                              ontap: () {
                                print(bloc.phoneController.text);
                                print(bloc.passwordController.text);
                                bloc.add(LoginStartEvents(phone: bloc.phoneController.text,password: bloc.passwordController.text));


                                },

                              height: 50.h,
                              width: 343.w,
                              fontsize: 15.sp,
                              color: AppTheme.mainColor,
                              fontcolor: Colors.white,
                              boxborder: Border.all(
                                  width: 0.5,
                                  color: Colors.grey
                              ),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (
                                          context) => RegisterView()));
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

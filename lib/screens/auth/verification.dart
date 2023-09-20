import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:thimar/core/design/res/app_logo.dart';
import 'package:thimar/screens/auth/change_password.dart';
import 'package:thimar/screens/auth/login.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/logic/toast.dart';
import '../../features/verification/bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../../core/logic/app_theme.dart';
import '../main/view.dart';


class VerificationView extends StatefulWidget {
  VerificationView({super.key, required this.phone, this.isActive = false,required this.fromForget});
  final String phone;
  final bool isActive;
  final bool fromForget;

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final bloc = KiwiContainer().resolve<VerificationBloc>();
  @override
  void initState() {

    super.initState();
    bloc.phone = widget.phone;
  }

  bool timeRunning=true;
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
                    LocaleKeys.Auth_You_can_log_in_now.tr(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.mainColor),
                ),
                Text(
                  '${LocaleKeys.Auth_Enter_the_component_code.tr()+bloc.phone}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppTheme.mainColorText,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    LocaleKeys.Auth_password.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.mainColor,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ), Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.h, vertical: 15.h),
                  child: PinCodeTextField(
                      onChanged: (h) {},
                      length: 4,
                      controller: bloc.codeController,
                      appContext: context,
                      obscureText: false,
                      textStyle: const TextStyle(color: Colors.black, fontSize: 19),
                      // textInputType: TextInputType.number,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.white.withOpacity(0),

                      textInputAction: TextInputAction.done,
                      enableActiveFill: true,
                      enabled: true, animationCurve: Curves.ease,
                      autoFocus: true,
                      onSubmitted: (value) {
                        if (bloc.codeController.text.isEmpty) {
                          Toast.show('enter the code', context);
                          return;
                        } else {
                          if (widget.isActive == false) {
                            bloc.add(VerificationStartEvents(
                              phone: widget.phone,
                              code: bloc.codeController.text,
                            ));
                          } else {

                            bloc.add(CheckCodeStartEvents(
                                phone: widget.phone,
                                code: bloc.codeController.text));
                          }
                        }
                      },
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      autoDisposeControllers: true,
                      autoDismissKeyboard: true,
                      pinTheme: PinTheme(
                      selectedColor: AppTheme.mainColor,
                  shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 55,
                  activeFillColor: Colors.white,
                  inactiveColor: AppTheme.mainColorText,
                  activeColor: AppTheme.mainColor,
                  disabledColor: Colors.white,
                  borderWidth: 0.9,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                  ),
      ),
                SizedBox(height: 20.h,),

                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if (widget.isActive == false) {
                      if (state is VerificationSuccessState) {
                        navigateTo(MainView());


                      } else if (state is VerificationFailedState) {
                        Toast.show(state.msg, context);
                      }
                    } else if (state is CheckCodeSuccessState) {
                      if (widget.fromForget==true){
                        navigateTo(ChangePasswordView(
                            phone: widget.phone,
                            code: bloc.codeController.text));
                      } else {
                        navigateTo(MainView());
                        }

                    } else if (state is CheckCodeFailedState) {
                      Toast.show(state.msg, context);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text:  LocaleKeys.Auth_Confirm_the_code.tr(),
                      onTap: () {
                        if (bloc.codeController.text.isEmpty) {
                          Toast.show('enter the code', context);
                          return;
                        } else {
                          if (widget.isActive == false) {
                            bloc.add(VerificationStartEvents(
                              phone: widget.phone,
                              code: bloc.codeController.text,
                            ));
                          } else {
                            bloc.add(CheckCodeStartEvents(
                                phone: widget.phone,
                                code: bloc.codeController.text));
                          }
                        }
                      },
                      height: 60.h,
                      width: 343.w,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    LocaleKeys.Auth_Did_you_not_receive_the_code.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppTheme.mainColorText,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    LocaleKeys.Auth_You_can_resend_code_after.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppTheme.mainColorText,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if(state is ResendCodeSuccessState){
                      bloc.counterController.restart();

                    }else if (state is ResendCodeFailedState){
                      Toast.show(state.msg, context);
                    }
                  },
                  builder: (context, state) {
                    return timeRunning ?
                    Column(
                      children: [
                        Center(
                          child: CircularCountDownTimer(
                            width: 66.03,
                            height: 69.45,
                            duration: bloc.counter.toInt(),
                            //initialDuration:bloc.counter.toInt(),
                            controller: bloc.counterController,
                            fillColor: AppTheme.mainColor,
                            fillGradient: null,
                            ringColor: const Color(0xFFF3F3F3),
                            ringGradient: null,
                            backgroundColor: Colors.white,
                            backgroundGradient: null,
                            strokeWidth: 2.0,
                            strokeCap: StrokeCap.butt,
                            textFormat: CountdownTextFormat.MM_SS,
                            textStyle: TextStyle(color: AppTheme.mainColor, fontSize: 22),
                            isReverse: true,
                            isReverseAnimation: true,
                            isTimerTextShown: true,
                            autoStart: true,
                            onStart: () {
                              debugPrint('Countdown Started');
                            },
                            onComplete: () {
                              debugPrint('Countdown Ended');
                              timeRunning=false;
                              setState(() {

                              });
                            },



                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: AppButton(
                            text: LocaleKeys.Auth_Re_transmitter.tr(),
                            onTap: () {},
                            height: 37.h,
                            width: 133.w,
                            type: btnType.off,

                          ),
                        ),
                      ],
                    ):Center(
                      child: AppButton(
                        text: LocaleKeys.Auth_Re_transmitter.tr(),
                        type: btnType.outLine,
                        onTap: () {
                          bloc.add(ResendCodeStartEvents(phone: widget.phone));
                          timeRunning=true;
                          setState(() {
                          });
                        },
                        height: 37.h,
                        width: 133.w,
                      ),
                    )

                    ;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.Auth_Already_have_an_account.tr(),
                      style: TextStyle(
                        color: AppTheme.mainColor,
                        fontSize: 16.sp,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        navigateTo(LoginView());
                      },
                      child: Text(
                        LocaleKeys.Auth_sign_in.tr(),
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
        ),
      ),
    );
  }
}

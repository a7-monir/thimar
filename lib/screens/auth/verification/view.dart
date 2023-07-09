import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:thimar/helper/toast.dart';
import 'package:thimar/screens/auth/change_password/view.dart';
import 'package:thimar/screens/auth/forget_password/view.dart';
import 'package:thimar/screens/auth/login/view.dart';
import 'package:thimar/screens/auth/verification/bloc/bloc.dart';
import 'package:thimar/screens/auth/verification/bloc/events.dart';
import 'package:thimar/screens/auth/verification/bloc/states.dart';
import 'package:thimar/screens/home/view.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../helper/app_theme.dart';


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
    bloc.phone = widget.phone;
    super.initState();
  }

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
                    color: AppTheme.maingreycolor,
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
                  inactiveColor: Colors.white,
                  activeColor: Colors.white,
                  disabledColor: Colors.white,
                  borderWidth: .6,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeView()));

                      } else if (state is VerificationFailedState) {
                        Toast.show(state.error, context);
                      }
                    } else if (state is CheckCodeSuccessState) {
                      if (widget.fromForget==true){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordView(
                            phone: widget.phone,
                            code: bloc.codeController.text),));
                      } else {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeView()));}
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ForgetPasswordView()));
                    } else if (state is CheckCodeFailedState) {
                      Toast.show(state.error, context);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text:  LocaleKeys.Auth_Confirm_the_code.tr(),
                      fontcolor: Colors.white,
                      ontap: () {
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
                      fontsize: 18,
                      color: AppTheme.mainColor,
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
                      fontSize: 18,
                      color: AppTheme.maingreycolor,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    LocaleKeys.Auth_You_can_resend_code_after.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.maingreycolor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if(state is ResendCodeSuccessState){
                      bloc.counterController.restart();

                    }else if (state is ResendCodeFailedState){
                      Toast.show(state.error, context);
                    }
                  },
                  builder: (context, state) {
                    return Center(
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
                        },



                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: AppButton(
                    text: LocaleKeys.Auth_Re_transmitter.tr(),
                    ontap: () {
                      bloc.add(ResendCodeStartEvents(phone: widget.phone));
                    },
                    height: 37,
                    width: 133,
                    fontsize: 15,
                    color: Colors.white,
                    fontcolor: AppTheme.mainColor,
                    boxborder: Border.all(color: AppTheme.mainColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.Auth_Already_have_an_account.tr(),
                      style: TextStyle(
                        color: AppTheme.maingreycolor,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView(),));
                      },
                      child: Text(
                        LocaleKeys.Auth_sign_in.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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

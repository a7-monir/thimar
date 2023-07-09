import 'package:easy_localization/easy_localization.dart'as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/screens/auth/change_password/bloc/bloc.dart';
import 'package:thimar/screens/auth/change_password/bloc/events.dart';
import 'package:thimar/screens/auth/change_password/bloc/states.dart';
import 'package:thimar/screens/auth/login/view.dart';
import 'package:thimar/screens/home/view.dart';
import '../../../constant/app_input.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../helper/toast.dart';


class ChangePasswordView extends StatefulWidget {
  final String phone;
  final dynamic code;


  ChangePasswordView({
    required this.phone,
    required this.code,
  });

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {

  final bloc = KiwiContainer().resolve<ChangePasswordBloc>();

  void initState() {
    bloc.phone = widget.phone;
    bloc.code=widget.code;

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
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  LocaleKeys.Auth_Forgot_your_password.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4C8613),
                  ),
                ),
                Text(
                  LocaleKeys.Auth_enter_new_password.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppCustomInput(
                  label: LocaleKeys.Auth_password.tr(),

                  prefix: 'lock.png',
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: bloc.passwordController,
                ),
                SizedBox(height: 20.h,),
                AppCustomInput(
                  label:LocaleKeys.Auth_password.tr(),
                  prefix: 'lock.png',
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: bloc.confirmPasswordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer(
                  bloc:bloc,
                  listener: (context, state) {
                  if(state is ChangePasswordSuccessState){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                  }else if (state is ChangePasswordFailState){
                    Toast.show(state.error, context);
                  }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: 'تغيير كلمة المرور',
                      fontcolor: Colors.white,
                      ontap: () {
                      if(
                      bloc.isDataValid(context)){
                        bloc.add(ChangePasswordStartEvents(
                          phone:widget.phone,
                          code: widget.code,
                          password: bloc.passwordController.text,
                        ));
                      }
                      },
                      height: 60,
                      width: 343.w,
                      fontsize: 15.sp,
                      color: AppTheme.mainColor,
                    );
                  },
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    LocaleKeys.Auth_You_dont_have_an_account.tr(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView(),));
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

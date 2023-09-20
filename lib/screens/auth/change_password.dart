import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:thimar/core/design/res/app_logo.dart';
import 'package:thimar/core/logic/app_theme.dart';

import 'package:thimar/screens/auth/login.dart';

import '../../core/design/res/app_input.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/logic/toast.dart';
import '../../features/change_password/bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../main/view.dart';

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
    bloc.code = widget.code;

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
                const AppLogo(),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "تغيير كلمة المرور",
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
                AppInput(
                  label: LocaleKeys.Auth_password.tr(),
                  prefix: 'assets/icons/lock.png',
                  textInputType: TextInputType.visiblePassword,
                  inputType: InputType.password,
                  controller: bloc.passwordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppInput(
                  label: LocaleKeys.Auth_password.tr(),
                  prefix: 'assets/icons/lock.png',
                  textInputType: TextInputType.visiblePassword,
                  inputType: InputType.password,
                  controller: bloc.confirmPasswordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is ChangePasswordSuccessState) {
                      navigateTo(MainView());
                    } else if (state is ChangePasswordFailState) {
                      Toast.show(state.msg, context);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: 'تغيير كلمة المرور',
                      onTap: () {
                        if (bloc.isDataValid(context)) {
                          bloc.add(ChangePasswordStartEvents(
                            phone: widget.phone,
                            code: widget.code,
                            password: bloc.passwordController.text,
                          ));
                        }
                      },
                      height: 60.h,
                      width: 343.w,
                    );
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
                        color: Colors.grey,
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

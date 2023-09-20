import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_button.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import 'package:thimar/core/design/res/app_logo.dart';
import 'package:thimar/core/logic/app_theme.dart';
import 'package:thimar/screens/auth/login.dart';
import '../core/design/res/app_input.dart';
import '../core/logic/helper_methods.dart';
import '../core/logic/toast.dart';
import '../features/edit_password/bloc.dart';
import '../generated/locale_keys.g.dart';


class EditPasswordView extends StatefulWidget {


  @override
  State<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<EditPasswordView> {

  final bloc = KiwiContainer().resolve<EditPasswordBloc>();

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
                  label: 'كلمة المرور القديمة',
                  prefix: 'assets/icons/lock.png',
                  textInputType: TextInputType.visiblePassword,
                  inputType: InputType.password,
                  controller: bloc.oldPasswordController,

                ),
                SizedBox(
                  height: 20.h,
                ),
                AppInput(
                  label: 'كلمة المرور الجديدة',
                  prefix: 'assets/icons/lock.png',
                  textInputType: TextInputType.visiblePassword,
                  inputType: InputType.password,
                  controller: bloc.newPasswordController,

                ),
                SizedBox(
                  height: 20.h,
                ),

                BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is EditPasswordSuccessState) {
                      Navigator.pop(context);
                    } else if (state is EditPasswordFailState) {
                      Toast.show(state.msg, context);
                    }
                  } ,
                  builder: (context, state) {
                    if(state is EditPasswordLoadingState){
                      return AppLoading();
                    }else{
                      return AppButton(
                      text: 'تغيير كلمة المرور',
                      onTap: () {
                        bloc.add(EditPasswordStartEvents(
                            oldPassword: bloc.oldPasswordController.text,
                            newPassword: bloc.newPasswordController.text)
                        );
                      },
                      height: 60.h,
                      width: 343.w,
                    );}

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

import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/constant/app_image.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/constant/app_logo.dart';
import 'package:thimar/generated/locale_keys.g.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/screens/auth/login.dart';
import '../../constant/app_input.dart';
import '../../features/city/view.dart';
import '../../features/register/bloc.dart';
import '../../helper/helper_methods.dart';
import '../../helper/toast.dart';
import 'verification.dart';


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
                    fontSize: 16.sp,
                    color: AppTheme.mainGreyColor,
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
                        label: LocaleKeys.Auth_user_name.tr(),
                        prefix: 'assets/icons/user.png',
                        controller: bloc.fullNameController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppInput(
                          inputType: InputType.phone,
                          label: lang.tr(LocaleKeys.Auth_Mobile_number),
                          prefix: 'assets/icons/phoneicon.png',
                          textInputType: TextInputType.phone,
                          controller: bloc.phoneController,),
                      SizedBox(
                        height: 10.h,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return AppInput(
                          onPress:  () {
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
                              if (value != null) {
                                var city = value;
                                bloc.cityId = city.id;
                                bloc.cityName = city.name;
                                setState(() {});
                              }
                            });
                          },
                          hint: lang.tr(LocaleKeys.Auth_City),
                          prefix: 'assets/icons/city.png',
                          label: bloc.cityName,
                        );
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppInput(
                        controller: bloc.passwordController,
                        label: lang.tr(LocaleKeys.Auth_password),
                        prefix: 'assets/icons/lock.png',
                        inputType: InputType.password,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppInput(
                        controller: bloc.confirmationPasswordController,
                        label: lang.tr(LocaleKeys.Auth_password),
                        prefix: 'assets/icons/lock.png',
                        inputType: InputType.password,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BlocConsumer(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            navigateTo(VerificationView(
                              phone: bloc.phoneController.text,
                              fromForget: false,
                            ));
                          } else if (state is RegisterFailState) {
                            Toast.show(state.error, context);
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoadingState) {
                            return AppLoading();
                          } else {
                            return AppButton(
                              text: lang.tr(LocaleKeys.Auth_Registration),
                              onTap: () {
                                bloc.unfocus(context);
                                if (bloc.isDataVaild(context)) {
                                  bloc.add(RegisterStartEvents());
                                  Toast.show(bloc.model!.message, context);
                                }
                              },
                              height: 50.h,
                              width: 343.w,
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
                            onTap: () {
                              navigateTo(LoginView());
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

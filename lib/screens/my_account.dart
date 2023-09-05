import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_image.dart';
import 'package:thimar/constant/app_info.dart';
import 'package:thimar/constant/app_loading.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/helper/cache_helper.dart';
import 'package:thimar/helper/helper_methods.dart';
import 'package:thimar/helper/toast.dart';
import 'package:thimar/screens/complaint.dart';
import 'package:thimar/screens/policy.dart';
import 'package:thimar/screens/wallet.dart';
import '../features/logout_bloc/bloc.dart';
import 'auth/splash/view.dart';
import 'about_us.dart';
import 'address.dart';

import 'contact.dart';
import 'faqs.dart';
import 'profile.dart';

class MyAccountView extends StatefulWidget {
  const MyAccountView({Key? key}) : super(key: key);

  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  final bloc = KiwiContainer().resolve<LogoutBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 375.w,
                    height: 217.h,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(50),
                        ),
                        color: AppTheme.mainColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'حسابي',
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                            height: 76.h,
                            width: 76.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: AppImage(
                              CacheHelper.getImage(),
                              fit: BoxFit.fill,
                            )),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          CacheHelper.getFullName(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '+${CacheHelper.getPhone()}',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFA2D273),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 375.w,
                      height: 217.h,
                      child: Image.asset(
                        'assets/images/mask.png',
                        fit: BoxFit.cover,
                      )),
                ],
              ),
              SizedBox(
                height: 34.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w, left: 32.w),
                child: Column(
                  children: [
                    AppInfo(
                      icon: 'user.png',
                      title: 'البيانات الشخصية',
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PersonalInfoView(),
                            ));
                      },
                    ),
                    AppInfo(
                        icon: 'wallet.png',
                        title: 'المحفظة',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WalletView(),
                            ))),
                    AppInfo(
                        icon: 'location.png',
                        title: 'العناوين',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressView(),
                            ))),
                    AppInfo(
                        icon: 'question.png',
                        title: 'أسئلة متكررة',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FaqsView(),
                            ))),
                    AppInfo(
                        icon: 'safe.png',
                        title: 'سياسة الخصوصية',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PolicyView(),
                            ))),
                    AppInfo(
                        icon: 'call.png',
                        title: 'تواصل معنا',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactUsView(),
                            ))),
                    AppInfo(
                        icon: 'edit2.png',
                        title: 'الشكاوي والأقتراحات',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComplaintView(),
                            ))),
                    AppInfo(
                        icon: 'share.png',
                        title: 'مشاركة التطبيق',
                        ontap: () => null),
                    AppInfo(
                        icon: 'info.png',
                        title: 'عن التطبيق',
                        ontap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsView(),
                            ))),
                    AppInfo(
                        icon: 'note2.png',
                        title: 'الشروط والأحكام',
                        ontap: () => null),
                    AppInfo(
                        icon: 'star.png',
                        title: 'تقييم التطبيق',
                        ontap: () => null),
                    SizedBox(
                      height: 50.h,
                      child: BlocConsumer(
                        bloc: bloc,
                        listener: (context, state) {
                          if(state is LogoutSuccessState){
                            Toast.show('تم تسجيل الخروج بنجاح', context);
                            navigateTo(SplashView());
                          }else if(state is LogoutFailState) {
                            Toast.show(state.error, context);
                          }
                        },
                        builder: (context, state) {
                          if(state is LogoutLoadingState){
                            return AppLoading();
                          }else{
                            return InkWell(
                            onTap: () {
                             // navigateTo(LoginView());
                              bloc.add(LogoutStartEvents());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: AppTheme.mainColor),
                                ),
                                Image.asset('assets/icons/off.png'),
                              ],
                            ),
                          );}

                        },
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_info.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/screens/auth/login/view.dart';
import 'package:thimar/screens/home/confirm_order/add_adress/view.dart';
import 'package:thimar/screens/home/my_account/complaint/view.dart';
import 'package:thimar/screens/home/my_account/pay/view.dart';
import 'package:thimar/screens/home/my_account/privacy/view.dart';
import 'package:thimar/screens/home/my_account/questions/view.dart';
import 'package:thimar/screens/home/my_account/wallet/view.dart';
import '../../../models/model.dart';
import 'about_us/view.dart';
import 'address/view.dart';
import 'call_us/view.dart';
import 'personal_info/view.dart';

class MyAccountView extends StatelessWidget {
  const MyAccountView({Key? key}) : super(key: key);

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
                      color: AppTheme.mainColor
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('حسابي',
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        SizedBox(height: 20.h,),
                        Image.asset('assets/images/user.png'),
                        Text('محمد علي',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        SizedBox(height: 5.h,),
                        Text('+96654787856',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFA2D273),
                          ),),
                      ],
                    ),

                  ),
                  SizedBox(
                      width: 375.w,
                      height: 217.h,
                      child: Image.asset('assets/images/mask.png',fit: BoxFit.cover,)),
                ],
              ),
              SizedBox(height: 34.h,),
              Padding(
                padding: EdgeInsets.only(right: 30.w,left: 32.w),
                child: Column(
                  children: [
                    AppInfo(icon:'user.png', title:'البيانات الشخصية',
                      ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoView(),));}, ),
                    AppInfo(icon:'wallet.png', title: 'المحفظة',
                        ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletView(),))),
                    AppInfo(icon:'location.png',title: 'العناوين',ontap:  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressView(),))),

                    AppInfo(icon:'question.png', title:'أسئلة متكررة', ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionsView(),))),

                    AppInfo(icon:'safe.png',title: 'سياسة الخصوصية',ontap:  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyView(),))),

                    AppInfo(icon:'call.png', title:'تواصل معنا',ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CallUsView(),))),

                    AppInfo(icon:'edit2.png',title: 'الشكاوي والأقتراحات', ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => const ComplaintView(),))),

                    AppInfo(icon:'share.png', title: 'مشاركة التطبيق',ontap:  () => null),

                    AppInfo(icon:'info.png', title: 'عن التطبيق',ontap:  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsView(),))),

                    AppInfo(icon: 'note2.png', title:'الشروط والأحكام', ontap: () => null),
                    AppInfo(icon: 'star.png',title: 'تقييم التطبيق',ontap: () => null),
                    SizedBox(
                      height: 50.h,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) =>const LoginView() ,));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('تسجيل الخروج',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: AppTheme.mainColor),),
                            Image.asset('assets/icons/off.png'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 90.h,),
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

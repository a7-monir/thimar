import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/screens/home/main/widget/custom_categories.dart';
import 'package:thimar/screens/home/main/widget/custom_get_products.dart';
import 'package:thimar/screens/home/main/widget/custom_slider.dart';
import 'package:badges/badges.dart' as badges;
import '../../../helper/custom_text.dart';
import '../../../mutual_bloc/bloc_categories/bloc.dart';
import '../../../mutual_bloc/bloc_get_products/bloc.dart';
import '../../../mutual_bloc/bloc_slider/bloc.dart';
import '../cart/view.dart';




class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        actions: [

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartView(),));
            },
            child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: Align(
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  shape:BadgeShape.circle,
                  badgeColor:AppTheme.mainColor ,
                  borderSide: const BorderSide(width: 0.9, color: Colors.white),
                ),
                position: BadgePosition.topStart(top: -12, start: -4),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
                child: Container(
                  width: 33,
                  height: 33,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EFE0),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Image.asset(
                    "assets/icons/market.png",
                    width: 20,
                  ),
                ),


              ),
            ),),
          )
        ],
        leading: Padding(
          padding: EdgeInsets.only(right:15.w),
          child: Row(
            children: [
              Image.asset('assets/icons/minlogo.png'),
              SizedBox(width: 3.w,),
              Text('سلة ثمرة',style: TextStyle(color: AppTheme.mainColor,fontSize: 14.sp,fontWeight: FontWeight.bold
              ),),

            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Column(
          children:  [
            Text(
              'التوصيل إلى',
              style: TextStyle(
                  color: AppTheme.mainColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'شارع الملك فهد - جدة',
              style: TextStyle(
                color: AppTheme.mainColor,
                fontSize: 14.sp,
              ),
            )
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 343.w,
                height: 55.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FBF7),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 0.2,
                    color: const Color(0xFFF9FBF7),
                  ),
                ),
                child: Center(
                  child: TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ابحث عن ما تريد',
                      prefixIcon: Image(
                        image: AssetImage('assets/icons/search.png'),
                      ),

                    ),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ),
              //SizedBox(height: 20.h,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 164.h,
                child: const SliderApp(),
              ),
              SizedBox(height: 20.h,),
              CustomTitle(
                title: "الأقسام",
                text: "عرض الكل",
                onTap: () {},
              ),
              SizedBox(height: 18.h,),
              SizedBox(
                height: 120.h,
                child: CustomCategory(),
              ),
              SizedBox(height: 20.h,),
              Container(
                alignment: Alignment.centerRight,
                child: const CustomOnlyTitle(title: "الأصناف"),
              ),
              GetProducts(),

            ],
          ),
        ),


    );
  }
}

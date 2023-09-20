import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/logic/app_theme.dart';
import 'package:badges/badges.dart' as badges;
import '../../core/design/res/app_image.dart';
import '../../core/logic/custom_text.dart';
import '../../core/logic/helper_methods.dart';
import '../cart/view.dart';
import 'widget/custom_categories.dart';
import 'widget/custom_get_products.dart';
import 'widget/custom_slider.dart';
import '../search.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {



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
                badgeContent:Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                  ),
                ),
                child: Container(
                  width: 33.w,
                  height: 33.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EFE0),
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                  child:
                  AppImage( "assets/icons/market.png",w: 20.w,)
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                child: GestureDetector(
                  onTap: (){
                    navigateTo(SearchView());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        width: 0.2.w,
                        color: const Color(0xFFF9FBF7),
                      ),
                    ),
                    child: TextFormField(
                      enabled:false ,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ابحث عن ما تريد',
                        prefixIcon:
                        AppImage('assets/icons/search.png'),

                      ),
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                ),
              ),

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
                child: const CustomOnlyTitle(title: "الأصناف", color:Colors.black),
              ),
              SizedBox(height: 8.h,),
              GetProducts(),

            ],
          ),
        ),


    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/screens/home/my_order/about_order/view.dart';
import '../../../helper/app_theme.dart';
import 'finished_order/view.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TabController controller = TabController(length: 2);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'طلباتي',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.mainColor,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      child: TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          labelStyle: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          indicator: BoxDecoration(
                            color: AppTheme.mainColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          unselectedLabelColor: AppTheme.mainColor,
                          tabs: const [
                            Tab(text: 'الحاليه',
                            ),
                            Tab(text: 'المنتهية'),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(
                          children: [
                        ListView.separated(

                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) =>
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutOrderView(),));
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'طلب #4587',
                                            style: TextStyle(
                                                color: AppTheme.mainColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '27 يونيو 2023',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppTheme.maingreycolor),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset('assets/items/1.png'),
                                              SizedBox(width: 5.w,),
                                              Image.asset('assets/items/2.png'),
                                              SizedBox(width: 5.w,),
                                              Image.asset('assets/items/3.png'),
                                              SizedBox(width: 5.w,),
                                              Container(
                                                height: 25.h,
                                                width: 25.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: AppTheme.thirdcolor,
                                                ),
                                                child: Center(
                                                  child: Text('+2',
                                                    style: TextStyle(
                                                        color: AppTheme.mainColor,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.bold),),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            width: 70.w,
                                            height: 23.h,
                                            decoration: BoxDecoration(
                                                color: AppTheme.thirdcolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text('بإنتظار الموافقة',style: TextStyle(
                                                color: AppTheme.mainColor,
                                                  fontSize: 11.sp
                                              ),),
                                            ),
                                          ),
                                          SizedBox(height: 30.h,),
                                          Text('180 ر.س',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: AppTheme.mainColor),),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  height: 20.h,
                                ),
                            itemCount: 20),
                        ListView.separated(

                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const FinishedOrderView(),));
                              },
                              child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'طلب #4587',
                                            style: TextStyle(
                                                color: AppTheme.mainColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '27 يونيو 2023',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppTheme.maingreycolor),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset('assets/items/1.png'),
                                              SizedBox(width: 5.w,),
                                              Image.asset('assets/items/2.png'),
                                              SizedBox(width: 5.w,),
                                              Image.asset('assets/items/3.png'),
                                              SizedBox(width: 5.w,),
                                              Container(
                                                height: 25.h,
                                                width: 25.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: AppTheme.thirdcolor,
                                                ),
                                                child: Center(
                                                  child: Text('+2',
                                                    style: TextStyle(
                                                        color: AppTheme.mainColor,
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.bold),),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            width: 70.w,
                                            height: 23.h,
                                            decoration: BoxDecoration(
                                                color: AppTheme.thirdcolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text('منتهي',style: TextStyle(
                                                color: AppTheme.mainColor,
                                                  fontSize: 11.sp
                                              ),),
                                            ),
                                          ),
                                          SizedBox(height: 30.h,),
                                          Text('180 ر.س',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: AppTheme.mainColor),),
                                        ],
                                      ),

                                    ],
                                  ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 20,
                                ),
                            itemCount: 20),

                      ]),
                    ),


                  ],
                ))));
  }
}

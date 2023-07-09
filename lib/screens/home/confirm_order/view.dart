import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/screens/home/confirm_order/add_adress/view.dart';

import '../../../helper/app_theme.dart';
import 'cards/view.dart';
import 'finish_order/view.dart';

class CompleteOrderView extends StatelessWidget {
  const CompleteOrderView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorCodes = {
      50: Color.fromRGBO(76, 134, 19, 1),
      100: Color.fromRGBO(76, 134, 19, 1),
      200: Color.fromRGBO(76, 134, 19, 1),
      300: Color.fromRGBO(76, 134, 19, 1),
      400: Color.fromRGBO(76, 134, 19, 1),
      500: Color.fromRGBO(76, 134, 19, 1),
      600: Color.fromRGBO(76, 134, 19, 1),
      700: Color.fromRGBO(76, 134, 19, 1),
      800: Color.fromRGBO(76, 134, 19, 1),
      900: Color.fromRGBO(76, 134, 19, 1),
    };
// Green color code: FF93cd48
    MaterialColor customColor = MaterialColor(0xFF93cd48, colorCodes);
    void _selectdate(){

      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2050),
        builder:(context, child) => Theme(data: ThemeData(primarySwatch: customColor), child: child!),
      );
    }
    void _selecttime(){
      showTimePicker(context: context, initialTime: TimeOfDay.now());
    }
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('إتمام الطلب',style: TextStyle(fontSize: 20.sp,color: AppTheme.mainColor,fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDDE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppTheme.mainColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),

        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 20,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الإسم : محمد',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 5.h,),
                    Text('الجوال : 05068285914',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('اختر عنوان التوصيل',
                          style: TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 26.w,
                          height: 26.h,
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor: AppTheme.thirdcolor,
                              onPressed: (){},
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,),
                              elevation: 0.0,
                              child: Icon(Icons.add,color: AppTheme.mainColor,size: 40,),
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height:10.h,
                    ),
                    Container(
                      width: 339.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppTheme.mainColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,),
                        child: TextButton(
                          onPressed: (){
                            showModalBottomSheet(
                              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                  topRight:Radius.circular(50),topLeft: Radius.circular(50)),),
                              context: context,
                              builder: (context) =>const AddAdressView(),
                            );
                          },
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Text('المنزل : 119 طريق الملك عبدالعزيز',
                                  style: TextStyle(color:AppTheme.mainColor,fontSize: 15.sp ),),
                              ),
                              Icon( Icons.keyboard_arrow_down_outlined,color: AppTheme.mainColor,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Text('تحديد وقت التوصيل',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 163.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              border: Border.all( color: Colors.grey.shade200,),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextButton(
                            onPressed: _selectdate,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('اختر اليوم والتاريخ',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppTheme.mainColor
                                ),),
                                SizedBox(width: 10.w,),
                                Icon(Icons.calendar_month,color: AppTheme.mainColor,),],
                            ),
                          ),

                        ),
                        Container(
                          width: 163.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              border: Border.all( color: Colors.grey.shade200,),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextButton(
                            onPressed:_selecttime,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('اختر الوقت',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppTheme.mainColor
                                ),),
                                SizedBox(width: 10.w,),
                                Icon(Icons.access_time_outlined,color: AppTheme.mainColor,),],
                            ),
                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Text('ملاحظات وتعليمات',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),),
                    Container(
                      width: 342.w,
                      height: 117.h,
                      decoration: BoxDecoration(
                          border: Border.all( color: Colors.grey.shade200,),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: const InputDecoration(
                              border: InputBorder.none
                          ),
                          style: TextStyle(
                              fontSize: 15.sp
                          ),
                          cursorColor: Colors.grey,
                          maxLines: 5,
                        ),
                      ),

                    ),
                    SizedBox(height: 10.h,),
                    Text('اختر طريقة الدفع',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tab(
                          child: Container(
                            height: 49.54.h,
                            width: 103.67.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppTheme.mainColor)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/money.png',),
                                SizedBox(width: 10.w,),
                                Text('كاش',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                    topRight:Radius.circular(50),topLeft: Radius.circular(50)),),
                                  context: context,
                                builder: (context) =>const CardsView(),
                              );
                            },
                            child: Container(
                              height: 49.54.h,
                              width: 103.67.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.shade400)
                              ),
                              child: Center(
                                child: Text('البطاقات المدفوعه',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                    topRight:Radius.circular(50),topLeft: Radius.circular(50)),),
                                context: context,
                                builder: (context) =>const CardsView(),
                              );
                            },
                            child: Container(
                              height: 49.54.h,
                              width: 103.67.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.shade400)
                              ),
                              child: Center(
                                child: Text('المحفظة',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Text('ملخص الطلب',
                      style: TextStyle(
                          color: AppTheme.mainColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.h,),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:const Color(0xFFF3F8EE),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('إجمالي المنتجات',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                Text('180ر.س',style: TextStyle(
                                    color: AppTheme.mainColor,
                                    fontSize: 15.sp),),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('سعر التوصيل',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                Text('40ر.س',style: TextStyle(
                                    color: AppTheme.mainColor,
                                    fontSize: 15.sp),),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الخصم',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                Text('-40ر.س',style: TextStyle(
                                    color: AppTheme.mainColor,
                                    fontSize: 15.sp),),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('المجموع',
                                  style: TextStyle(
                                      color: AppTheme.mainColor,
                                      fontSize: 15.sp),),
                                Text('180ر.س',style: TextStyle(
                                    color: AppTheme.mainColor,
                                    fontSize: 15.sp),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 80.h,)





                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0,left: 10,right: 10),
              child: AppButton(
                text: 'إنهاء الطلب',
                color: AppTheme.mainColor,
                width: 343.w,
                height: 60.h,
                fontcolor: Colors.white,
                fontsize: 15.sp,
                ontap: (){
                  showModalBottomSheet(
                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                        top:Radius.circular(50))),


                    context: context,
                    builder: (context) => const FinishOrderView(),);
                },
              ),
            ),
          ],
        ),



    );
  }
}

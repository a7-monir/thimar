import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/screens/home/sections/bloc/states.dart';
import '../../../../constant/app_button.dart';
import '../../../../helper/app_theme.dart';
import '../../../helper/toast.dart';
import '../show_product/view.dart';


import 'bloc/bloc.dart';
import 'bloc/events.dart';

class SectionsView extends StatefulWidget {
  final categoryId;
  final categoryName;

  const SectionsView({super.key,required this.categoryId, required this.categoryName});


  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {




  final bloc = KiwiContainer().resolve<CategoriesProductBloc>();

  @override
  void initState() {
    bloc.add(CategoriesProductStartEvent(categoriesProductId: widget.categoryId,));
    super.initState();
  }

  double start = 0.0;
  double end = 100.0;
  List<String> type = ["1", "0"];
  bool isActive = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //toolbarHeight: 60,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.categoryName,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.mainColor),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 12),
          child: Container(
            height: 26,
            width: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: const Color(0xFFE8EEDE),
            ),
            child:Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppTheme.mainColor,
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 15.w,right: 15.w,top: 30),
              child: Container(
                height: 55,
                padding:  EdgeInsets.only(left: 15.w,right: 15.w,),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EFE0),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 0.2,
                    color: const Color(0xFFE8EFE0),
                  )
                ),
                child: TextFormField(
                  maxLines: 1,
                  decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ابحث عن ما تريد',
                      prefixIcon: Image.asset('assets/icons/search.png'),
                      suffixIcon: Padding(
                        padding:  EdgeInsets.only(top: 8.h,bottom: 7.h),
                        child: InkWell(
                          onTap: (){
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(38.0),
                                    topRight: Radius.circular(38.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder: (context, setState) {
                                    return DraggableScrollableSheet(
                                      initialChildSize: 0.55,
                                      maxChildSize: 0.55,
                                      minChildSize: 0.55,
                                      expand: false,
                                      builder: (context, scrollController) {
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 25,
                                              vertical: 20,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "تصفية",
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                                  ),
                                                ),const Divider(
                                                  color: Color(0xFFF6F6F6),
                                                  height: 1.0,
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ), const Text(
                                                  "السعر",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black),
                                                ),
                                                RangeSlider(
                                                  values: RangeValues(start,end),
                                                min: 0,
                                                  max: 100,
                                                  divisions: 100,
                                                  activeColor: AppTheme.mainColor,
                                                  inactiveColor: Colors.grey,
                                                  labels: RangeLabels(start.toString(), end.toString()),
                                                  onChanged: (RangeValues values){
                                                    setState((){
                                                      start =values.start;
                                                      end=values.end;
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                const Divider(
                                                  color: Color(0xFFF6F6F6),
                                                  height: 1.0,
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                const Text(
                                                  "الترتيب",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        setState((){
                                                          type.last='0';
                                                          if (type.last == '0') {
                                                            isActive = true;
                                                          } else {
                                                            isActive = false;
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 23,
                                                        height: 23,
                                                        decoration: BoxDecoration(
                                                          color: type.last == '0' ? AppTheme.mainColor : Colors.white,
                                                          borderRadius: BorderRadius.circular(6),
                                                          border: Border.all(
                                                            width: 0.5,
                                                            color: const Color(0xFFECECEC),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.h,
                                                    ),
                                                    Text(
                                                      "من السعر الأقل للأعلي",
                                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.mainColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          type.last = '1';
                                                          if (type.last == '1') {
                                                            isActive = true;
                                                          } else {
                                                            isActive == false;
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 23,
                                                        height: 23,
                                                        decoration: BoxDecoration(
                                                          color: type.last == '1' ? AppTheme.mainColor : Colors.white,
                                                          borderRadius: BorderRadius.circular(6),
                                                          border: Border.all(
                                                            width: 0.5,
                                                            color: const Color(0xFFECECEC),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.h,
                                                    ),
                                                    Text(
                                                      "من السعر الأعلى للأقل",
                                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.mainColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                const Divider(
                                                  color: Color(0xFFF6F6F6),
                                                  height: 1.0,
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                AppButton(
                                                    text: "تطبيق",
                                                    ontap: (){
                                                      ///TODO///
                                                    },
                                                    height: 60,
                                                    fontsize: 11.sp,
                                                    color:  AppTheme.mainColor,
                                                    fontcolor: Colors.white)
                                              ],

                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },);
                                },);
                          },
                          child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppTheme.mainColor,
                              ),
                              child: Image.asset('assets/icons/setting.png')
                          ),
                        ),
                      )
                  ),

                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(height: 18.h,),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if(state is CategoriesProductLoadingState){
                  return Center(child: Container(width: 30, height: 30, child: const CircularProgressIndicator()));
                }else if (state is CategoriesProductSuccessState){
                  return GridView.builder(

                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 315,
                    ),
                    itemCount: bloc.model!.data.length,

                    itemBuilder: (contex,index){
                      return InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowProduct(
                            productsId: bloc.model!.data[index].id,
                            productsName: bloc.model!.data[index].title,
                          )));},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 117.h,
                                      padding: const EdgeInsets.all(19),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color(0xFFFFFCF7),
                                      ),
                                      child: Image.network(
                                        bloc.model!.data[index].mainImage,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        // width: 107.w,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 50,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(11),
                                            bottomRight: Radius.circular(11),
                                          ),
                                          color: AppTheme.mainColor,
                                        ),
                                        child: const Text(
                                          "-45%",
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),  SizedBox(
                                  height: 18.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      bloc.model!.data[index].title,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "السعر / ${bloc.model!.data[index].unit.name}",
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF808080)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${bloc.model!.data[index].price} ر٫س",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "45 ر٫س",
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppTheme.mainColor,
                                            decoration: TextDecoration.lineThrough,
                                            decorationColor: AppTheme.mainColor,
                                            decorationThickness: 4,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Spacer(),
                                        data[index]['isSelected'] == false
                                            ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              data[index]['isSelected'] = !data[index]['isSelected'];
                                            });
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: AppTheme.mainColor,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.add,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                            : Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (data[index]['quantity'] > 1) {
                                                    data[index]['quantity']--;
                                                  } else if (data[index]['quantity'] <= 1) {
                                                    data[index]['isSelected'] = !data[index]['isSelected'];
                                                  }
                                                  // data[index]['isSelected'] = !data[index]['isSelected'];
                                                });
                                              },
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: data[index]['quantity'] > 1 ? AppTheme.mainColor : const Color(0xFFFFFCF7),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                alignment: Alignment.center,
                                                // trash_icon
                                                child: data[index]['quantity'] > 1
                                                    ? const Icon(
                                                  Icons.remove,
                                                  size: 10,
                                                  color: Colors.white,
                                                )
                                                    : Image.asset(
                                                  'assets/icons/trash.png',
                                                  width: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(data[index]['quantity'].toString()),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  data[index]['quantity']++;
                                                  // data[index]['isSelected'] = !data[index]['isSelected'];
                                                });
                                              },
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.mainColor,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    AppButton(text: "أضف للسلة",
                                        ontap: (){
                                          Toast.show("تم الاضافة بنجاح", context);
                                        },
                                        height: 33.h,
                                        fontsize: 11.sp,
                                        color: AppTheme.mainColor,
                                        fontcolor: Colors.white)
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },

                  );
                }
                else if ((state is CategoriesProductFailedState)){
                  return Center(
                  child: Text(state.error,),
                );
                } else {
                  return Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
            },),


          ],
        ),
      ),

    );
  }
  final List<Map> data = List.generate(10, (index) => {'quantity': 0, 'isSelected': false});
}

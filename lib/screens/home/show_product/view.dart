import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_button.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:thimar/helper/toast.dart';
import 'package:thimar/screens/home/show_product/bloc/states.dart';


import '../cart/view.dart';
import 'bloc/bloc.dart';
import 'bloc/events.dart';

class ShowProduct extends StatefulWidget {
  final int productsId;
  final String productsName;

  const ShowProduct(
      {super.key, required this.productsId, required this.productsName});

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  final bloc = KiwiContainer().resolve<ShowProductBloc>();

  @override
  void initState() {
   bloc.add(ShowProductStartEvent(productsId: widget.productsId,));
    super.initState();
  }
  int quantity = 1;
  bool isSelected = false;
  final List<Map> data = List.generate(10, (index) => {'quantity': 0, 'isSelected': false});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDDE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.favorite_border_outlined,
                      color: AppTheme.mainColor),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is ShowProductLoadingState){
            return Center(child: Container(width: 30, height: 30, child: const CircularProgressIndicator()));
          }else if (state is ShowProductSuccessState){

            return SafeArea(
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 244.h,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          child: Stack(
                            children: [
                              Swiper(
                                itemBuilder:  (BuildContext context, index){
                                  return Image.network(
                                    bloc.model!.data.images[index].url,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width.w,
                                    height: MediaQuery.of(context).size.height.h,
                                  );
                                  },
                                autoplay: true,
                                itemCount: bloc.model!.data.images.length,
                                scrollDirection: Axis.horizontal,
                                pagination: SwiperPagination(
                                  alignment: Alignment.bottomCenter,
                                  builder: DotSwiperPaginationBuilder(
                                    color: Colors.white.withOpacity(0.5),
                                    activeColor: Colors.white,
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 90,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding:  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "طماطم",
                                widget.productsName,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "السعر / ${bloc.model!.data.unit.name}",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF808080)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${bloc.model!.data.discount}%",
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFFFF0000)),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "${bloc.model!.data.price} ر٫س",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                  ),
                                  Text(
                                    "${bloc.model!.data.priceBeforeDiscount} ر٫س",
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
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8EFE0),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                    onTap: (){
                                      setState(() {
                                        quantity++;
                                        isSelected = !isSelected;
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
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(quantity > 1){
                                            quantity--;
                                          }else if (quantity<=1){
                                            isSelected = !isSelected;
                                          }
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
                                        // trash_icon
                                        child: const Icon(
                                          Icons.remove,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ),
                      Divider(
                        color: Color(0xFFE8EFE0),
                        height: 1.0,

                      ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "كود المنتج",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              bloc.model!.data.code,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF808080)),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xFFE8EFE0),
                        height: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "تفاصيل المنتج",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              bloc.model!.data.description,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF808080), height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                           children: [
                             Text(
                               "التقييمات",
                               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                             ),
                             const Spacer(),
                             Text(
                               "عرض الكل",
                               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                             ),
                           ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            height: 120.h,
                            child: ListView.builder(
                              itemCount: 2,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_,i){
                                return Padding(
                                    padding:const EdgeInsets.all(8.0),
                                  child:  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8.0),
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(255, 211, 208, 208).withOpacity(0.5),
                                          spreadRadius: -7,
                                          blurRadius: 20,
                                          offset: const Offset(0, 0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Spacer(),
                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "محمد علي",
                                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF333333)),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    RatingBar.builder(
                                                        initialRating: 0,
                                                        maxRating: 0,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 17,

                                                        itemBuilder: (context, index) => const Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:(rating){
                                                          print(rating);
                                                        }
                                                        ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                const Text(
                                                  "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد",
                                                  softWrap: false,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w900,
                                                    color: Color(0xFF333333),
                                                  ),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                        ),
                                        SizedBox(
                                          width: 7.w,
                                        ),
                                        CircleAvatar(
                                          radius: (25),
                                          backgroundColor: Colors.white.withOpacity(0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: Image.network(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPQzg2-modiBeSBIckt_NcpipPPGQfZA_dbQ&usqp=CAU",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                },
                                ),
                          ),
                        ],
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "منتجات مشابهة",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              height: 230.h,
                              child: GridView.builder(
                                itemCount: data.length,
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 350 / 2,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      padding: const EdgeInsets.all(10),
                                      child:  Column(
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
                                               child:Image.network(
                                                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIF6WZccHClMK8sqiUuWWfRlT8d6omOLXuYQ&usqp=CAU',
                                                 fit: BoxFit.fill,
                                                 width: 107.w,
                                               ),
                                             ) ,
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
                                          ),
                                          SizedBox(height: 18.h,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "طماطم",
                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              const Text(
                                                "السعر / 1كجم",
                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF808080)),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "45 ر٫س",
                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Text(
                                                    "45 ر٫س",
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
                                                    onTap: (){
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
                                                      child:  const Icon(
                                                        Icons.add,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                      : Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          setState(() {
                                                            if(data[index]['quantity']>1){
                                                              data[index]['quantity']--;
                                                            }else if (data[index]['quantity'] <= 1){
                                                              data[index]['isSelected'] = !data[index]['isSelected'];
                                                            }
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
                                                          child: data[index]['quantity'] > 1
                                                          ?const Icon(
                                                            Icons.remove,
                                                            size: 10,
                                                            color: Colors.white,
                                                          ) :Image.asset(
                                                            'assets/icons/trash_icon.png',
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
                                                        onTap: (){
                                                          setState(() {
                                                            data[index]['quantity']++;
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
                                              )
                                            ],
                                          )
                                        ],
                                      ),

                                    );
                                  },),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),


                    ],
                  ),
                ),
            );
          }else if (state is ShowProductFailedState){
            return Center(
              child: Text(state.error),
            );
          }else{
            return Center(
              child: Container(
                width: 30,
                height: 30,
                child: const CircularProgressIndicator(),
              ),
            );
          }

        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: AppTheme.mainColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Toast.show("تم الاضافة بنجاح", context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(38.0),
                          topRight: Radius.circular(38.0),
                        ),
                      ),
                      context: context,
                      builder: (_){
                      return FractionallySizedBox(
                        heightFactor: 0.3,
                        child: ClipRRect(
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8EFE0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/check.png',
                                        width: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "تم إضافة المنتج بنجاح",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE8EFE0),
                                            borderRadius: BorderRadius.circular(11),
                                          ),
                                          child: Image.network(
                                            'https://wp.alithemes.com/html/nest/demo/assets/imgs/shop/cat-1.png',
                                            width: 50,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "طماطم",
                                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                const Text(
                                                  "الكمية: 5",
                                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF808080)),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Text(
                                                  "200ر٫س",
                                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                                ),
                                              ],
                                            ),
                                        ),
                                      ],
                                    ),
                                ),
                                const Divider(
                                  color: Color(0xFFE8EFE0),
                                  height: 1.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: AppButton(
                                            text:  "التحويل إلى السلة",
                                            ontap: () {
                                              Navigator.pop(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => CartView()));
                                            }, height: 45,
                                            fontsize: 12,
                                            color: AppTheme.mainColor,
                                            fontcolor: Colors.white,

                                          ),
                                        ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: AppButton(
                                            text:  "تصفح العروض",
                                            ontap: () {
                                              Navigator.pop(context);
                                            },
                                          height: 45,
                                            color: AppTheme.mainColor,
                                            fontcolor: Colors.white,
                                            fontsize: 12,
                                          ),
                                        ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ) ,
                        ),
                      );
                      },
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF6AA431),
                      ),
                      child: Image.asset(
                        'assets/icons/shopping.png',
                        width: 16,
                      ),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    const Text(
                      "إضافة إلي السلة",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                "225.ر٫س",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


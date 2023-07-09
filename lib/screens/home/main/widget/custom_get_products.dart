import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/mutual_bloc/bloc_add_to_cart/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_add_to_cart/events.dart';
import '../../../../constant/app_button.dart';
import '../../../../helper/app_theme.dart';
import '../../../../helper/toast.dart';
import '../../../../mutual_bloc/bloc_get_products/bloc.dart';
import '../../../../mutual_bloc/bloc_get_products/events.dart';
import '../../../../mutual_bloc/bloc_get_products/states.dart';
import '../../show_product/view.dart';


class GetProducts extends StatefulWidget {
  const GetProducts({Key? key}) : super(key: key);


  @override
  State<GetProducts> createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {

  final getProductBloc = KiwiContainer().resolve<GetProductsBloc>()..add(GetProductsStartEvent());

  final addToCartBloc =  KiwiContainer().resolve<AddToCartBloc>()..add(AddToCartStartEvent());


  //int amount = 1 ;
  //GetProducts? check ;
  late int id;

  @override
  Widget build(BuildContext context) {


    return  BlocBuilder(
      bloc: getProductBloc,
      builder: (context, state) {
        if(state is GetProductsLoadingState){
          return Center(child: Container(width: 30, height: 30, child: const CircularProgressIndicator()));
        }else if (
        state is GetProductsSuccessState){
          return GridView.builder(
            itemCount: getProductBloc.getProductsModel!.data.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 315,
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowProduct(
                        productsId: getProductBloc.getProductsModel!.data[index].id,
                        productsName: getProductBloc.getProductsModel!.data[index].title,
                      ),
                    ),
                  );

                },
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
                            //padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                               color: const Color(0xFFFFFCF7),

                            ),
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(11) ,
                              child: Image.network(
                                getProductBloc.getProductsModel!.data[index].mainImage,
                                fit: BoxFit.fill,
                                width: double.infinity,



                              ),
                            ),
                          ),
                          if (getProductBloc.getProductsModel!.data[index].discount != null)
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
                                  child: Text(
                                    getProductBloc.getProductsModel!.data[index].discount.toString(),
                                    style: const TextStyle(fontSize: 11,
                                        fontWeight: FontWeight.w900, color: Colors.white),
                                  ),
                                )),
                        ],
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            getProductBloc.getProductsModel!.data[index].title,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                          ),
                           SizedBox(
                            height: 8.h,
                          ),
                          Text("السعر/${getProductBloc.getProductsModel!.data[index].unit.name}",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF808080)),

                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "${getProductBloc.getProductsModel!.data[index].price} ر٫س",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              if (getProductBloc.getProductsModel!.data[index].priceBeforeDiscount != null)
                                Text(
                                  "${getProductBloc.getProductsModel!.data[index].priceBeforeDiscount} ر٫س",
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
                              const Spacer(),
                              data[index]['isSelected'] == false ?
                                  InkWell(
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
                          SizedBox(height: 5.h,),
                          Center(
                            child: BlocBuilder(
                              bloc: addToCartBloc,
                              builder: (context, state) {
                                return AppButton(
                              text: 'أضف للسلة',
                              ontap: (){
                                addToCartBloc.productId = getProductBloc.getProductsModel!.data[index].id;
                                addToCartBloc.add(AddToCartStartEvent(
                                ));
                                Toast.show("تم الاضافة بنجاح", context);
                              },
                              color:  AppTheme.mainColor,
                              height: 30.h,
                              width: 115.w,
                              fontsize: 12.sp,
                              fontcolor: Colors.white,);
  },
),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
             );
        }else if (state is GetProductsFailedState){
          return Center(
            child: Text(state.error),
          );
        }else {
          return Center(
            child: Container(
              width: 30,
              height: 30,
              child: const CircularProgressIndicator(color: Colors.red,),
            ),
          );
        }
    },);
  }
  final List<Map> data = List.generate(10, (index) => {'quantity': 1, 'isSelected': false});
}

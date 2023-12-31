import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import '../../../core/design/res/app_button.dart';
import '../../../../features/add_to_cart/bloc.dart';
import '../../../../features/get_products/bloc.dart';
import '../../../core/logic/app_theme.dart';
import '../../../core/design/res/app_image.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../features/cart/bloc.dart';
import '../../show_product.dart';



class GetProducts extends StatefulWidget {
  const GetProducts({Key? key}) : super(key: key);


  @override
  State<GetProducts> createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {

  final getProductBloc = KiwiContainer().resolve<GetProductsBloc>()..add(GetProductsStartEvent());

  final addToCartBloc =  KiwiContainer().resolve<AddToCartBloc>();
  final bloc = KiwiContainer().resolve<ShowCartBloc>()..add(ShowCartStartEvent());

  //int amount = 1 ;
  //GetProducts? check ;
  late int id;

  @override
  Widget build(BuildContext context) {


    return  BlocBuilder(
      bloc: getProductBloc,
      builder: (context, state) {
        if(state is GetProductsLoadingState){
          return AppLoading();
        }else if (
        state is GetProductsSuccessState){
          var list = state.model.list;
          return GridView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 332,
              crossAxisSpacing: 6.h,
              //childAspectRatio: 160/283
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding:  EdgeInsets.symmetric(horizontal: 16.w,),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  navigateTo(
                    ShowProduct(
                    productsId: list[index].id,
                    productsName: list[index].title,
                      isFavorite: list[index].isFavorite,
                  ),);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  padding:EdgeInsets.all(11.r),
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(0,2),
                        blurRadius: 11.r
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                  borderRadius:BorderRadius.circular(11.r),
                  child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 117.h,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.r),
                                 color: const Color(0xFFFFFCF7),
                              ),
                              child:
                              AppImage(list[index].mainImage, fit: BoxFit.fill, w: double.infinity,),
                            ),
                            if (list[index].discount != null)
                              Container(
                                clipBehavior: Clip.antiAlias,
                                padding:EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h) ,
                                decoration: BoxDecoration(
                                  borderRadius:  BorderRadiusDirectional.only(
                                    bottomStart : Radius.circular(11.r),
                                  ),
                                  color: AppTheme.mainColor,
                                ),
                                child: Text(
                                 '${(list[index].discount*100).toInt()}%' ,
                                  style:  TextStyle(fontSize: 14.sp,
                                      fontWeight: FontWeight.w900, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            list[index].title,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                          ),
                           SizedBox(
                            height: 8.h,
                          ),
                          Text("السعر/${list[index].unit.name}",
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: Color(0xFF808080)),

                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "${list[index].price.toInt()} ر٫س",
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                              ),

                              if (list[index].priceBeforeDiscount != null)
                                Text(
                                  "${list[index].priceBeforeDiscount} ر٫س",
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppTheme.mainColor,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: AppTheme.mainColor,
                                    decorationThickness: 4,
                                    fontSize: 12.sp,
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
                                      width: 30.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: AppTheme.mainColor,
                                        borderRadius: BorderRadius.circular(6.r),
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
                                      width: 16.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: data[index]['quantity'] > 1 ? AppTheme.mainColor : const Color(0xFFFFFCF7),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      alignment: Alignment.center,
                                      // trash_icon
                                      child: data[index]['quantity'] > 1
                                          ? const Icon(
                                        Icons.remove,
                                        size: 10,
                                        color: Colors.white,
                                      )
                                          :
                                      AppImage( 'assets/icons/trash.png',w: 16.w,)
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
                                      width: 16.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: AppTheme.mainColor,
                                        borderRadius: BorderRadius.circular(4.r),
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
                            child: AppButton(
                              text: 'أضف للسلة',
                              onTap: (){
                                addToCartBloc.add(AddToCartStartEvent(productId: list[index].id ));
                                bloc.add(ShowCartStartEvent());
                                setState(() {});
                              },
                              height: 30.h,
                              width: 115.w,
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
            child: Text(state.msg),
          );
        }else {
          return AppLoading();
        }
    },);
  }
  final List<Map> data = List.generate(10, (index) => {'quantity': 1, 'isSelected': false});
}

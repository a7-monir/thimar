import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/constant/app_failed.dart';
import 'package:thimar/constant/app_image.dart';
import 'package:thimar/constant/app_loading.dart';
import '../constant/appbar.dart';
import '../features/favorites/bloc.dart';
import '../helper/app_theme.dart';
import '../helper/helper_methods.dart';
import 'show_product.dart';


class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final bloc = KiwiContainer().resolve<FavoritesBloc>()..add(FavoritesStartEvent());
  late bool isSelected=false;
  final List<Map> data = List.generate(10, (index) => {'quantity': 0, 'isSelected': false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child:CustomAppBar(title:'المفضلة' ,),),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10.h),
        child: BlocBuilder(
          bloc: bloc,
  builder: (context, state) {
            if(state is FavoritesLoadingState){return AppLoading();}
            else if (state is FavoritesSuccessState){
              return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 290,
                crossAxisSpacing: 16.h,

              ),
              itemCount: bloc.model!.list.length,
              itemBuilder: (context,index){
                return InkWell(
                    onTap: (){
                      navigateTo(
                        ShowProduct(
                          productsId: bloc.model!.list[index].id,
                          productsName: bloc.model!.list[index].title,
                          isFavorite: bloc.model!.list[index].isFavorite,
                        ),);
                    },
                    child:Container(
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
                                  AppImage( bloc.model!.list[index].mainImage,fit: BoxFit.fill,w: double.infinity ,),

                                ),
                                if (bloc.model!.list[index].discount != null)
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
                                      '${(bloc.model!.list[index].discount*100).toInt()}%' ,
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
                                bloc.model!.list[index].title,
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text("السعر/${bloc.model!.list[index].unit.name}",
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: Color(0xFF808080)),

                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${bloc.model!.list[index].price.toInt()} ر٫س",
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: AppTheme.mainColor),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  if (bloc.model!.list[index].priceBeforeDiscount != null)
                                    Text(
                                      "${bloc.model!.list[index].priceBeforeDiscount} ر٫س",
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
                            ],
                          )
                        ],
                      ),
                    )


                );
              },

            );}
            else if (state is FavoritesFailedState){return AppFailed(msg: state.error);}
            else{return AppLoading();}

  },
),
      ),

    );
  }
}

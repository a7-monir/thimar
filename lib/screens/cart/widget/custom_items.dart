import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../core/logic/app_theme.dart';
import '../../../features/cart/bloc.dart';


class ProductItem extends StatefulWidget {
   ProductItem({Key? key, required this.index,}) : super(key: key);

   int index;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  final bloc = KiwiContainer().resolve<ShowCartBloc>()..add(ShowCartStartEvent());
  final deleteBloc = KiwiContainer().resolve<ShowCartBloc>();

  int quantity=1;
  bool isSelected =false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 211, 208, 208)
                  .withOpacity(0.5),
              spreadRadius: -7,
              blurRadius: 20,
              offset:
              Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 92.w,
              height: 92.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFE8EFE0),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Image.network(
                bloc.model!.list[widget.index].image,
                width: 80,
              ),
            ),
            SizedBox(
              width: 14.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bloc.model!.list[widget.index].title,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.mainColor),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "${bloc.model!.list[widget.index].price} ر٫س",

                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.mainColor),
                  ),
                  Container(
                    width: 77.w,
                    height: 35.h,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EFE0),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            quantity++;
                            setState(() {

                            });
                          },
                          child: Container(
                            width: 23.w,
                            height: 23.h,
                            decoration: BoxDecoration(
                              color: AppTheme.mainColor,
                              borderRadius:
                              BorderRadius.circular(6.r),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.mainColor),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            if (quantity > 1) {
                              quantity--;
                            } else if (quantity <= 1) {
                              isSelected = ! isSelected;
                            }
                            setState(() {});
                          },
                          child: Container(
                            width: 23.w,
                            height: 23.h,
                            decoration: BoxDecoration(
                              color: AppTheme.mainColor,
                              borderRadius:
                              BorderRadius.circular(6.r),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.remove,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                // data[index].remove(data[index]);
                deleteBloc.add(DeleteStartEvens(
                  id: bloc.model!.list[widget.index].id,
                  index: widget.index,
                ));
                setState(() {});
                // Toast.show("تم المسح بنجاح", context);
              },
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(37, 255, 0, 0),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/trash.png',
                  width: 20.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

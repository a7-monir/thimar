import 'package:flutter/material.dart';
import 'package:thimar/helper/app_theme.dart';



class ItemList extends StatelessWidget {
  const ItemList({super.key});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 412,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),)

            ),
            child: Image.asset('assets/items/tomato2.png',fit: BoxFit.fill,),
          ),
          Container(

            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),)

            ),
            child: Image.asset('assets/items/tomato2.png',fit: BoxFit.fill,),
          ),
          Container(
            //width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),)

            ),
            child: Image.asset('assets/items/tomato2.png',fit: BoxFit.fill,),
          ),
          Container(
            //width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),)

            ),
            child: Image.asset('assets/items/tomato2.png',fit: BoxFit.fill,),
          ),
          Container(
            //width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),)

            ),
            child: Image.asset('assets/items/tomato2.png',fit: BoxFit.fill,),
          ),
        ],
      ),
    );

  }
}









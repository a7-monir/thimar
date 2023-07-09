import 'package:flutter/material.dart';

class BasketList extends StatelessWidget {
  const BasketList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/items/category.png'),
      ],
    );
  }
}
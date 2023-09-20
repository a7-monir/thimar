import 'package:flutter/material.dart';

class AppFailed extends StatelessWidget {
  final String msg;
  const AppFailed({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg),
    );
  }
}
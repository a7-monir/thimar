part of 'bloc.dart';
 class ForgetPasswordEvents{}

 class ForgetPasswordStartEvents extends ForgetPasswordEvents{
  String phone;

  ForgetPasswordStartEvents({
   required this.phone,

  });
 }
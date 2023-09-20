part of 'bloc.dart';
class LogoutStates{}

class LogoutLoadingState extends LogoutStates{}

class LogoutSuccessState extends LogoutStates{
  String msg;
  LogoutSuccessState({
    required this.msg,
  }){showMessage(msg);}
}

class LogoutFailState extends LogoutStates{
  int statusCode;
  String msg;
  LogoutFailState({
    required this.statusCode,
    required this.msg,
  });
}
part of 'bloc.dart';

class LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final String msg;

  LoginSuccessState({required this.msg,}){
    showMessage(msg);
  }
}

class LoginFailState extends LoginStates{
  int statusCode;
  String msg;
  LoginFailState({
    required this.statusCode,
    required this.msg,
  }){

  }
}
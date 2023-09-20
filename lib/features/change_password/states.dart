part of 'bloc.dart';
class ChangePasswordState{}

class ChangePasswordLoadingState extends ChangePasswordState{}

class ChangePasswordSuccessState extends ChangePasswordState{
  final String msg;
  ChangePasswordSuccessState({required this.msg}){
    showMessage(msg);
  }
}

class ChangePasswordFailState extends ChangePasswordState{
  int statusCode;
  String msg;
  ChangePasswordFailState({
    required this.statusCode,
    required this.msg,
  });
}
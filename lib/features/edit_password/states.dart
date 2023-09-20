part of 'bloc.dart';

class EditPasswordStates{}

class EditPasswordLoadingState extends EditPasswordStates{}

class EditPasswordSuccessState extends EditPasswordStates{
  final String msg;
  EditPasswordSuccessState({required this.msg}){
    showMessage(msg);
  }
}

class EditPasswordFailState extends EditPasswordStates{
  int statusCode;
  String msg;
  EditPasswordFailState({
    required this.statusCode,
    required this.msg,
  });
}
part of 'bloc.dart';
class ConfirmOrderStates {}

class ConfirmOrderLoadingState extends ConfirmOrderStates {}

class ConfirmOrderSuccessState extends ConfirmOrderStates {
  final String msg;
  ConfirmOrderSuccessState({required this.msg}){
    showMessage(msg);
  }
}

class ConfirmOrderFailedState extends ConfirmOrderStates {
  String msg;
  int statusCode;
  ConfirmOrderFailedState({
    required this.msg,
    required this.statusCode,
  });
}
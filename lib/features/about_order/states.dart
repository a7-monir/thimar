part of 'bloc.dart';

class AboutOrderState{}

class AboutOrderLoadingState extends AboutOrderState {

}

class AboutOrderSuccessState extends AboutOrderState {
  final AboutOrderData model;
  AboutOrderSuccessState({required this.model,}){
   }

}

class AboutOrderFailedState extends AboutOrderState {
  String msg;
  int statusCode;
  AboutOrderFailedState({
    required this.statusCode,
    required this.msg,
  });


}


class CancelOrderLoadingState extends AboutOrderState {}

class CancelOrderSuccessState extends AboutOrderState {

}

class CancelOrderFailedState extends AboutOrderState {
  String msg;
  int statusCode;

  CancelOrderFailedState({
    required this.msg,
    required this.statusCode,
  });
}
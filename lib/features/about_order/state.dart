part of 'bloc.dart';

class AboutOrderState{}

class AboutOrderLoadingState extends AboutOrderState {}

class AboutOrderSuccessState extends AboutOrderState {

}

class AboutOrderFailedState extends AboutOrderState {
  String error;
  int errType;
  AboutOrderFailedState({
    required this.errType,
    required this.error,
  });


}


class CancelOrderLoadingState extends AboutOrderState {}

class CancelOrderSuccessState extends AboutOrderState {

}

class CancelOrderFailedState extends AboutOrderState {
  String error;
  int errType;

  CancelOrderFailedState({
    required this.errType,
    required this.error,
  });
}
part of 'bloc.dart';


class OrderStates{}


class ClientOrderLoadingState extends OrderStates {}

class ClientOrderSuccessState extends OrderStates {

  final OrderData model;
  ClientOrderSuccessState({
    required this.model,

  });
}

class ClientOrderFailedState extends OrderStates {
  String msg;
  int statusCode;
  ClientOrderFailedState({
    required this.statusCode,
    required this.msg,
  });
}

class CancelOrderLoadingState extends OrderStates {}

class CancelOrderSuccessState extends OrderStates {
  String msg;

  CancelOrderSuccessState({
    required this.msg,
  }){showMessage(msg);}
}

class CancelOrderFailedState extends OrderStates {
  String error;
  int errType;
  CancelOrderFailedState({
    required this.errType,
    required this.error,
  });
}

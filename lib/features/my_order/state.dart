part of 'bloc.dart';


class OrderState{}


class ClientOrderLoadingState extends OrderState {}

class ClientOrderSuccessState extends OrderState {

  ClientOrderSuccessState();
}

class ClientOrderFailedState extends OrderState {
  String error;
  int errType;
  ClientOrderFailedState({
    required this.errType,
    required this.error,
  });
}

// class CurrentOrderLoadingState extends OrderState {}
//
// class CurrentOrderSuccessState extends OrderState {
//
// }
//
// class CurrentOrderFailedState extends OrderState {
//   String error;
//   int errType;
//   CurrentOrderFailedState({
//     required this.errType,
//     required this.error,
//   });
// }



// class FinishedOrderLoadingState extends OrderState {}
//
// class FinishedOrderSuccessState extends OrderState {
//
// }
//
// class FinishedOrderFailedState extends OrderState {
//   String error;
//   int errType;
//   FinishedOrderFailedState({
//     required this.errType,
//     required this.error,
//   });
// }



class CancelOrderLoadingState extends OrderState {}

class CancelOrderSuccessState extends OrderState {

}

class CancelOrderFailedState extends OrderState {
  String error;
  int errType;
  CancelOrderFailedState({
    required this.errType,
    required this.error,
  });
}

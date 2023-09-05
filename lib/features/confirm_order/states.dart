part of 'bloc.dart';
class ConfirmOrderStates {}

class ConfirmOrderLoadingState extends ConfirmOrderStates {}

class ConfirmOrderSuccessState extends ConfirmOrderStates {}

class ConfirmOrderFailedState extends ConfirmOrderStates {
  String error;
  int errType;
  ConfirmOrderFailedState({
    required this.error,
    required this.errType,
  });
}
part of 'bloc.dart';
class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {}

class NotificationsFailedState extends NotificationsStates {

  String error;
  int errType;

  NotificationsFailedState({
    required this.error,
    required this.errType,
  });
}

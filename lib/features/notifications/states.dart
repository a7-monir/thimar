part of 'bloc.dart';
class NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
  final NotificationData model;
  NotificationsSuccessState({required this.model});
}

class NotificationsFailedState extends NotificationsStates {

  String msg;
  int statusCode;

  NotificationsFailedState({
    required this.msg,
    required this.statusCode,
  });
}

part of 'bloc.dart';
class LogoutState{}

class LogoutLoadingState extends LogoutState{}

class LogoutSuccessState extends LogoutState{}

class LogoutFailState extends LogoutState{
  int type;
  String error;
  LogoutFailState({
    required this.type,
    required this.error,
  });
}
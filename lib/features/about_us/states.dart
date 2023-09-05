part of 'bloc.dart';

class AboutStates{}

class AboutLoadingState extends AboutStates {}

class AboutSuccessState extends AboutStates {}

class AboutFailedState extends AboutStates {
  String error;
  int errType;
  AboutFailedState({
    required this.error,
    required this.errType,
  });
}
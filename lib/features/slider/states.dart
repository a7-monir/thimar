part of 'bloc.dart';
class SliderStates{}

class SliderLoadingState extends SliderStates {}

class SliderSuccessState extends SliderStates {
  final SliderData model;
  SliderSuccessState({
    required this.model,
  });
}

class SliderFailedState extends SliderStates {
  String msg;
  int statusCode;
  SliderFailedState({
    required this.msg,
    required this.statusCode,
  });
}












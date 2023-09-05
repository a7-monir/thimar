part of 'bloc.dart';
class SliderState{}

class SliderLoadingState extends SliderState {}

class SliderSuccessState extends SliderState {}

class SliderFailedState extends SliderState {
  String error;
  int errType;
  SliderFailedState({
    required this.error,
    required this.errType,
  });
}












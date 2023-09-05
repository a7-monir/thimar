part of 'bloc.dart';

class FaqsState{}

class FaqsLoadingState extends FaqsState {}

class FaqsSuccessState extends FaqsState {}

class FaqsFailedState extends FaqsState {
  String error;
  int errType;
  FaqsFailedState({
    required this.error,
    required this.errType,
  });
}
part of 'bloc.dart';

class FaqsStates{}

class FaqsLoadingState extends FaqsStates {}

class FaqsSuccessState extends FaqsStates {
  final FaqsData model;
  FaqsSuccessState({required this.model}){

  }
}

class FaqsFailedState extends FaqsStates {
  String msg;
  int statusCode;
  FaqsFailedState({
    required this.msg,
    required this.statusCode,
  });
}
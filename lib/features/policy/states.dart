part of 'bloc.dart';

class PolicyStates{}

class PolicyLoadingState extends PolicyStates {}

class PolicySuccessState extends PolicyStates {
  final PolicyData model;
  PolicySuccessState({
    required this.model,
  });
}

class PolicyFailedState extends PolicyStates {
  String msg;
  int statusCode;
  PolicyFailedState({
    required this.msg,
    required this.statusCode,
  });
}
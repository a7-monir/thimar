part of 'bloc.dart';

class PolicyState{}

class PolicyLoadingState extends PolicyState {}

class PolicySuccessState extends PolicyState {}

class PolicyFailedState extends PolicyState {
  String error;
  int errType;
  PolicyFailedState({
    required this.error,
    required this.errType,
  });
}
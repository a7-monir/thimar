part of 'bloc.dart';

class ProfileStates{}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
final ProfileData model;
ProfileSuccessState({
  required this.model,
});
}

class ProfileFailedState extends ProfileStates {
  String msg;
  int statusCode;
  ProfileFailedState({
    required this.msg,
    required this.statusCode,
  });
}
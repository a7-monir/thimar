part of 'bloc.dart';

class ProfileStates{}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {

}

class ProfileFailedState extends ProfileStates {
  String msg;
  int statusCode;
  ProfileFailedState({
    required this.msg,
    required this.statusCode,
  });
}
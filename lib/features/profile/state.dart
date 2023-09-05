part of 'bloc.dart';

class ProfileState{}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {

  //late final List<CartModel> list;
}

class ProfileFailedState extends ProfileState {
  String error;
  int errType;
  ProfileFailedState({
    required this.error,
    required this.errType,
  });
}
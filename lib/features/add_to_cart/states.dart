part of 'bloc.dart';
class AddToCartState{}


class AddToCartLoadingState extends AddToCartState {}

class AddToCartSuccessState extends AddToCartState {}

class AddToCartFailedState extends AddToCartState {
  String error;
  int type;
  AddToCartFailedState({
    required this.error,
    required this.type,
  });
}
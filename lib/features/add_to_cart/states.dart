part of 'bloc.dart';
class AddToCartState{}


class AddToCartLoadingState extends AddToCartState {}

class AddToCartSuccessState extends AddToCartState {
  final String msg;
  AddToCartSuccessState({required this.msg}){
    showMessage(msg);
  }
}

class AddToCartFailedState extends AddToCartState {
  String msg;
  int type;
  AddToCartFailedState({
    required this.msg,
    required this.type,
  });
}
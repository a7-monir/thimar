part of 'bloc.dart';

class CartStates {}

class ShowCartLoadingState extends CartStates {}

class ShowCartSuccessState extends CartStates {
  final CartModel model;
  ShowCartSuccessState({required this.model});
  //late final List<CartModel> list;
}

class ShowCartFailedState extends CartStates {
  String msg;
  int statusCode;
  ShowCartFailedState({
    required this.msg,
    required this.statusCode,
  });
}


class DeleteFromCartLoadingState extends CartStates {}

class DeleteFromCartSuccessState extends CartStates {
  final String msg;
  DeleteFromCartSuccessState({required this.msg}){showMessage(msg);}
  //late final List<CartModel> list;
}

class DeleteFromCartFailedState extends CartStates {
  String msg;
  int statusCode;
  DeleteFromCartFailedState({
    required this.msg,
    required this.statusCode,
  });
}



class AddCouponLoadingState extends CartStates {}

class AddCouponSuccessState extends CartStates {

}

class AddCouponFailedState extends CartStates {
  String error;
  int errType;
  AddCouponFailedState({
    required this.error,
    required this.errType,
  });
}


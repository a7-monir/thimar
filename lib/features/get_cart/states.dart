part of 'bloc.dart';

class CartStates {}

class ShowCartLoadingState extends CartStates {}

class ShowCartSuccessState extends CartStates {

  //late final List<CartModel> list;
}

class ShowCartFailedState extends CartStates {
  String error;
  int errType;
  ShowCartFailedState({
    required this.error,
    required this.errType,
  });
}


class DeleteFromCartLoadingState extends CartStates {}

class DeleteFromCartSuccessState extends CartStates {

  //late final List<CartModel> list;
}

class DeleteFromCartFailedState extends CartStates {
  String error;
  int errType;
  DeleteFromCartFailedState({
    required this.error,
    required this.errType,
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


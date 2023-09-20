part of 'bloc.dart';
class ProductStates {}

class ShowProductLoadingState extends ProductStates {}

class ShowProductSuccessState extends ProductStates {
  final ShowProductData model;
  ShowProductSuccessState({
    required this.model,
  });
}

class ShowProductFailedState extends ProductStates {
  String msg;
  int statusCode;
  ShowProductFailedState({
    required this.msg,
    required this.statusCode,
  });
}




class GetProductRateLoadingState extends ProductStates {}

class GetProductRateSuccessState extends ProductStates {
  final ProductRateData model;
  GetProductRateSuccessState({
    required this.model,
  });
}

class GetProductRateFailedState extends ProductStates {
  String msg;
  int statusCode;
  GetProductRateFailedState({
    required this.msg,
    required this.statusCode,
  });
}






class AddToFavoriteLoadingState extends ProductStates {}

class AddToFavoriteSuccessState extends ProductStates {
  final String msg;
  AddToFavoriteSuccessState({
    required this.msg,
  });
}

class AddToFavoriteFailedState extends ProductStates {
  String msg;
  int statusCode;
  AddToFavoriteFailedState({
    required this.statusCode,
    required this.msg,
  });
}



class RemoveFromFavoriteLoadingState extends ProductStates {}

class RemoveFromFavoriteSuccessState extends ProductStates {
  final String msg;
  RemoveFromFavoriteSuccessState({
    required this.msg,
  });
}

class RemoveFromFavoriteFailedState extends ProductStates {
  String msg;
  int statusCode;
  RemoveFromFavoriteFailedState({
    required this.statusCode,
    required this.msg,
  });
}

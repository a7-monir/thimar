part of 'bloc.dart';
class ProductState {}

class ShowProductLoadingState extends ProductState {}

class ShowProductSuccessState extends ProductState {

}

class ShowProductFailedState extends ProductState {
  String error;
  int errType;
  ShowProductFailedState({
    required this.error,
    required this.errType,
  });
}




class GetProductRateLoadingState extends ProductState {}

class GetProductRateSuccessState extends ProductState {

}

class GetProductRateFailedState extends ProductState {
  String error;
  int errType;
  GetProductRateFailedState({
    required this.error,
    required this.errType,
  });
}






class AddToFavoriteLoadingState extends ProductState {}

class AddToFavoriteSuccessState extends ProductState {}

class AddToFavoriteFailedState extends ProductState {
  String error;
  int errType;
  AddToFavoriteFailedState({
    required this.errType,
    required this.error,
  });
}



class RemoveFromFavoriteLoadingState extends ProductState {}

class RemoveFromFavoriteSuccessState extends ProductState {}

class RemoveFromFavoriteFailedState extends ProductState {
  String error;
  int errType;
  RemoveFromFavoriteFailedState({
    required this.errType,
    required this.error,
  });
}

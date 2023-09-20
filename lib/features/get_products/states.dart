part of 'bloc.dart';
class ProductsStates{}


class GetProductsLoadingState extends ProductsStates {}

class GetProductsSuccessState extends ProductsStates {
  final ProductsData model;
  GetProductsSuccessState({required this.model});
}

class GetProductsFailedState extends ProductsStates {
  String msg;
  int statusCode;
  GetProductsFailedState({
    required this.statusCode,
    required this.msg,
  });
}

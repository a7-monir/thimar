part of 'bloc.dart';
class GetProductsState{}


class GetProductsLoadingState extends GetProductsState {}

class GetProductsSuccessState extends GetProductsState {

}

class GetProductsFailedState extends GetProductsState {
  String error;
  int errType;
  GetProductsFailedState({
    required this.errType,
    required this.error,
  });
}

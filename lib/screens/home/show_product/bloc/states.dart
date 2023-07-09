class ShowProductState {}

class ShowProductLoadingState extends ShowProductState {}

class ShowProductSuccessState extends ShowProductState {

}

class ShowProductFailedState extends ShowProductState {
  String error;
  int errType;
  ShowProductFailedState({
    required this.error,
    required this.errType,
  });
}
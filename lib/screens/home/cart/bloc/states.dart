import 'dart:core';

import 'model.dart';

class ShowCartState {}

class ShowCartLoadingState extends ShowCartState {}

class ShowCartSuccessState extends ShowCartState {

  late final List<CartModel> list;
}

class ShowCartFailedState extends ShowCartState {
  String error;
  int errType;
  ShowCartFailedState({
    required this.error,
    required this.errType,
  });
}
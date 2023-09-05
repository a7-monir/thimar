part of 'bloc.dart';

class CategoriesProductStates {}

class CategoriesProductLoadingState extends CategoriesProductStates {}

class CategoriesProductSuccessState extends CategoriesProductStates {}

class CategoriesProductFailedState extends CategoriesProductStates {

  String error;
  int errType;

  CategoriesProductFailedState({
    required this.error,
    required this.errType,
  });
}

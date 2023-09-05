part of 'bloc.dart';
class CategoriesState{}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {}

class CategoriesFailedState extends CategoriesState {
  String error;
  int errType;
  CategoriesFailedState({
    required this.error,
    required this.errType,
  });
}

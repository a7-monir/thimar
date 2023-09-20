part of 'bloc.dart';
class CategoriesState{}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final CategoriesData model;
  CategoriesSuccessState({required this.model});
}

class CategoriesFailedState extends CategoriesState {
  String msg;
  int statusCode;
  CategoriesFailedState({
    required this.msg,
    required this.statusCode,
  });
}

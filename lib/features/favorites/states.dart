part of 'bloc.dart';
class FavoritesStates{}


class FavoritesLoadingState extends FavoritesStates {}

class FavoritesSuccessState extends FavoritesStates {
  final FavoritesData model;

  FavoritesSuccessState({required this.model,}){}
}

class FavoritesFailedState extends FavoritesStates {
  String msg;
  int statusCode;
  FavoritesFailedState({
    required this.statusCode,
    required this.msg,
  });
}
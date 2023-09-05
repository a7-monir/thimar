part of 'bloc.dart';
class FavoritesState{}


class FavoritesLoadingState extends FavoritesState {}

class FavoritesSuccessState extends FavoritesState {}

class FavoritesFailedState extends FavoritesState {
  String error;
  int errType;
  FavoritesFailedState({
    required this.errType,
    required this.error,
  });
}
part of 'bloc.dart';
class SearchState{}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {}

class SearchFailedState extends SearchState {
  String error;
  int errType;
  SearchFailedState({
    required this.error,
    required this.errType,
  });
}


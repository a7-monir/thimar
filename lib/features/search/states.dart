part of 'bloc.dart';
class SearchStates{}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final SearchData model;
  SearchSuccessState({
    required this.model,
  });
}

class SearchFailedState extends SearchStates {
  String msg;
  int statusCode;
  SearchFailedState({
    required this.msg,
    required this.statusCode,
  });
}


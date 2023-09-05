part of 'bloc.dart';

class SearchEvents{}

class SearchStartEvent extends SearchEvents {
  String keyword;
  SearchStartEvent(this.keyword);
}

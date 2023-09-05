part of 'bloc.dart';

class AboutOrderEvent{}

class AboutOrderStartEvent extends AboutOrderEvent{
  int id;
  AboutOrderStartEvent({required this.id});
}

class CancelOrderStartEvent extends AboutOrderEvent{
  final int id;

  CancelOrderStartEvent({required this.id});
}
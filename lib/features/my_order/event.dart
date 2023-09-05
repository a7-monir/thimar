part of 'bloc.dart';

class OrderEvent{}

class ClientOrderStartEvent extends OrderEvent{
  final String endPoint;
  ClientOrderStartEvent({required this.endPoint});
}

// class CurrentOrderStartEvent extends OrderEvent{}
//
// class FinishedOrderStartEvent extends OrderEvent{}


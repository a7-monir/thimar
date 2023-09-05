part of 'bloc.dart';

class AddRateEvents {}

class AddRateStartEvents extends AddRateEvents {
  String comment;
  double value;
  num ProductId;
  AddRateStartEvents({
    required this.comment,
    required this.value,
    required this.ProductId,
  });
}
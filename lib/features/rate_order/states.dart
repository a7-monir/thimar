part of 'bloc.dart';


class AddRateStates{}

class AddRateLoadingState extends AddRateStates{}

class AddRateSuccessState extends AddRateStates{
  String msg;
  AddRateSuccessState({
    required this.msg,
  }){showMessage(msg);}
}

class AddRateFailedState extends AddRateStates{
  int statusCode ;
  String msg;
  AddRateFailedState({
    required this.msg,
    required this.statusCode,
  });
}
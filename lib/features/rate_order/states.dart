part of 'bloc.dart';


class AddRateStates{}

class AddRateLoadingState extends AddRateStates{}

class AddRateSuccessState extends AddRateStates{

}

class AddRateFailedState extends AddRateStates{
  int type;
  String error;
  AddRateFailedState({
    required this.type,
    required this.error,
  });
}
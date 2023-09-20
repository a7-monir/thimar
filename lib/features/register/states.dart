part of 'bloc.dart';

class RegisterStates{}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
 final RegisterModel model;
 final String msg;
 RegisterSuccessState({
    required this.model,
   required this.msg,
  }){showMessage(msg);}
}

class RegisterFailState extends RegisterStates {
  int statusCode;
  String msg;
  RegisterFailState({
    required this.statusCode,
    required this.msg,
  });
}

class RegisterGetCitiesLoadingState extends RegisterStates {}

class RegisterGetCitiesSuccessState extends RegisterStates {
  final CityDataModel model;
  RegisterGetCitiesSuccessState({required this.model});
}

class RegisterGetCitiesFailState extends RegisterStates {
  final String msg;
  RegisterGetCitiesFailState({required this.msg});
}

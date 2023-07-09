import 'model.dart';

class RegisterState{}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailState extends RegisterState {
  int type;
  String error;
  RegisterFailState({
    required this.type,
    required this.error,
  });
}

class RegisterGetCitiesLoadingState extends RegisterState {}

class RegisterGetCitiesSuccessState extends RegisterState {
  final CityDataModel model;
  RegisterGetCitiesSuccessState({required this.model});
}

class RegisterGetCitiesFailState extends RegisterState {
  final String? error;
  RegisterGetCitiesFailState({this.error});
}

part of 'bloc.dart';
class ContactState{}

class ContactLoadingState extends ContactState {}

class ContactSuccessState extends ContactState {
}

class ContactFailedState extends ContactState {
  String error;
  int errType;
  ContactFailedState({
    required this.error,
    required this.errType,
  });
}



class CreateContactLoadingState extends ContactState {}

class CreateContactSuccessState extends ContactState {}

class CreateContactFailedState extends ContactState {
  String error;
  int errType;
  CreateContactFailedState({
    required this.error,
    required this.errType,
  });
}
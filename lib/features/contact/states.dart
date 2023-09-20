part of 'bloc.dart';
class ContactStates{}

class ContactLoadingState extends ContactStates {}

class ContactSuccessState extends ContactStates {
  final ContactData model;
  ContactSuccessState({required this.model}){

  }
}

class ContactFailedState extends ContactStates {
  String msg;
  int statusCode;
  ContactFailedState({
    required this.msg,
    required this.statusCode,
  });
}



class CreateContactLoadingState extends ContactStates {}

class CreateContactSuccessState extends ContactStates {
  final String msg;
  CreateContactSuccessState({required this.msg}){
    showMessage(msg);
  }
}

class CreateContactFailedState extends ContactStates {
  String msg;
  int statusCode;
  CreateContactFailedState({
    required this.msg,
    required this.statusCode,
  });
}
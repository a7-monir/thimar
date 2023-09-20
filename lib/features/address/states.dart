part of 'bloc.dart';

class AddressStates{}

class GetAddressLoadingState extends AddressStates {}

class GetAddressSuccessState extends AddressStates {
  final AddressData model;
  GetAddressSuccessState({required this.model}){

  }
}

class GetAddressFailedState extends AddressStates {
  String msg;
  int statusCode;
  GetAddressFailedState({
    required this.msg,
    required this.statusCode,
  }){showMessage(msg);}
}


class DeleteAddressLoadingState extends AddressStates {}

class DeleteAddressSuccessState extends AddressStates {

}

class DeleteAddressFailedState extends AddressStates {
  String msg;
  int statusCode;
  DeleteAddressFailedState({
    required this.msg,
    required this.statusCode,
  });
}



class EditAddressLoadingState extends AddressStates {}

class EditAddressSuccessState extends AddressStates {
  final AddressData model;
  final String msg;
  EditAddressSuccessState({required this.msg,required this.model}){
    showMessage(msg);
  }
}

class EditAddressFailedState extends AddressStates {
  String msg;
  int statusCode;
  EditAddressFailedState({
    required this.msg,
    required this.statusCode,
  });
}


class AddAddressLoadingState extends AddressStates {}

class AddAddressSuccessState extends AddressStates {
  final String msg;
  AddAddressSuccessState({required this.msg,}){
    showMessage(msg);
  }
}

class AddAddressFailedState extends AddressStates {
  String msg;
  int statusCode;
  AddAddressFailedState({
    required this.msg,
    required this.statusCode,
  });
}
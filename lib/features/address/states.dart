part of 'bloc.dart';

class AddressState{}

class GetAddressLoadingState extends AddressState {}

class GetAddressSuccessState extends AddressState {}

class GetAddressFailedState extends AddressState {
  String error;
  int errType;
  GetAddressFailedState({
    required this.error,
    required this.errType,
  });
}


class DeleteAddressLoadingState extends AddressState {}

class DeleteAddressSuccessState extends AddressState {}

class DeleteAddressFailedState extends AddressState {
  String error;
  int errType;
  DeleteAddressFailedState({
    required this.error,
    required this.errType,
  });
}



class EditAddressLoadingState extends AddressState {}

class EditAddressSuccessState extends AddressState {}

class EditAddressFailedState extends AddressState {
  String error;
  int errType;
  EditAddressFailedState({
    required this.error,
    required this.errType,
  });
}


class AddAddressLoadingState extends AddressState {}

class AddAddressSuccessState extends AddressState {}

class AddAddressFailedState extends AddressState {
  String error;
  int errType;
  AddAddressFailedState({
    required this.error,
    required this.errType,
  });
}
part of 'bloc.dart';

class EditPasswordEvents {}

class EditPasswordStartEvents extends EditPasswordEvents {
  String oldPassword;
  String newPassword;

  EditPasswordStartEvents({
    required this.oldPassword,
    required this.newPassword,
  });
}
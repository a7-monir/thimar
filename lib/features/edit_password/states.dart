part of 'bloc.dart';

class EditPasswordStates{}

class EditPasswordLoadingState extends EditPasswordStates{}

class EditPasswordSuccessState extends EditPasswordStates{}

class EditPasswordFailState extends EditPasswordStates{
  int type;
  String error;
  EditPasswordFailState({
    required this.type,
    required this.error,
  });
}
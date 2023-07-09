
class ChangePasswordState{}

class ChangePasswordLoadingState extends ChangePasswordState{}

class ChangePasswordSuccessState extends ChangePasswordState{}

class ChangePasswordFailState extends ChangePasswordState{
  int type;
  String error;
  ChangePasswordFailState({
    required this.type,
    required this.error,
  });
}
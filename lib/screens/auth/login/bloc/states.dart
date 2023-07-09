

class LoginState{}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{

}

class LoginFailState extends LoginState{
  int type;
  String error;
  LoginFailState({
    required this.type,
    required this.error,
  });
}
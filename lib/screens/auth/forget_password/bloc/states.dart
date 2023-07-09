class ForgetPasswordState{}

class ForgetPasswordLoadingState extends ForgetPasswordState{}

class ForgetPasswordSuccessState extends ForgetPasswordState{

  var phone;
  ForgetPasswordSuccessState({
    required this.phone,
  });
}

class ForgetPasswordFailState extends ForgetPasswordState {

  int type;
  String error;
  ForgetPasswordFailState({
    required this.type,
    required this.error,
  });

}

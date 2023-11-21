part of 'bloc.dart';
class VerificationStates{}

class VerificationLoadingState extends VerificationStates{
}

class VerificationSuccessState extends VerificationStates{

  final String msg;
  VerificationSuccessState({

    required this.msg
  }){showMessage(msg);}
}

class VerificationFailedState extends VerificationStates{
  final int statusCode;
  final String msg;
  VerificationFailedState({
    required this.statusCode,
    required this.msg,
  });
}

class CheckCodeLoadingState extends VerificationStates {}

class CheckCodeSuccessState extends VerificationStates {}

class CheckCodeFailedState extends VerificationStates {
 final int statusCode;
 final String msg;
  CheckCodeFailedState({
    required this.statusCode,
    required this.msg,
  });
}



class ResendCodeLoadingState extends VerificationStates {}

class ResendCodeSuccessState extends VerificationStates {}

class ResendCodeFailedState extends VerificationStates {
  int statusCode;
  String msg;
  ResendCodeFailedState({
    required this.statusCode,
    required this.msg,
  });
}



class VerificationState{}

class VerificationLoadingState extends VerificationState{
}

class VerificationSuccessState extends VerificationState{}

class VerificationFailedState extends VerificationState{
  int type;
  String error;
  VerificationFailedState({
    required this.type,
    required this.error,
  });
}

class CheckCodeLoadingState extends VerificationState {}

class CheckCodeSuccessState extends VerificationState {}

class CheckCodeFailedState extends VerificationState {
  int type;
  String error;
  CheckCodeFailedState({
    required this.type,
    required this.error,
  });
}



class ResendCodeLoadingState extends VerificationState {}

class ResendCodeSuccessState extends VerificationState {}

class ResendCodeFailedState extends VerificationState {
  int errType;
  String error;
  ResendCodeFailedState({
    required this.errType,
    required this.error,
  });
}


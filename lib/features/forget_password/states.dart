part of 'bloc.dart';
class ForgetPasswordStates{}

class ForgetPasswordLoadingState extends ForgetPasswordStates{}

class ForgetPasswordSuccessState extends ForgetPasswordStates{
  var phone;
  final String msg;
  ForgetPasswordSuccessState({
    required this.phone,
    required this.msg
  });
}

class ForgetPasswordFailState extends ForgetPasswordStates {

  int statusCode;
  String msg;
  ForgetPasswordFailState({
    required this.statusCode,
    required this.msg,
  });

}

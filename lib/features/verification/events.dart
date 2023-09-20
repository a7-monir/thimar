part of 'bloc.dart';
class VerificationEvents{}

class VerificationStartEvents extends VerificationEvents{
  String phone;
  dynamic code;

  VerificationStartEvents({
    required this.phone,
    required this.code,

  });

}

class CheckCodeStartEvents extends VerificationEvents {
  String phone;
  dynamic code;

  CheckCodeStartEvents({
    required this.phone,
    required this.code,

  });
}


class ResendCodeStartEvents extends VerificationEvents {
  String phone;

  ResendCodeStartEvents({
    required this.phone,
  });
}
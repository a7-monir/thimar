part of 'bloc.dart';
class VerificationEvents{}

class VerificationStartEvents extends VerificationEvents{
  String phone;
  dynamic code;
  // String type;
  // dynamic deviceToken;

  VerificationStartEvents({
    required this.phone,
    required this.code,
    // required this.type,
    // required this.deviceToken,
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
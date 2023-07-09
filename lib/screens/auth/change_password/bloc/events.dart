class ChangePasswordEvents {}

class ChangePasswordStartEvents extends ChangePasswordEvents {
  String phone;
  String password;
  dynamic code;
  ChangePasswordStartEvents({
    required this.phone,
    required this.password,
    required this.code,
  });
}
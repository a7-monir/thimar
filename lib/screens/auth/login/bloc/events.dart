
class LoginEvents {}

class LoginStartEvents extends LoginEvents {
  String phone;
  String password;
  LoginStartEvents({
    required this.phone,
    required this.password,
  });
}


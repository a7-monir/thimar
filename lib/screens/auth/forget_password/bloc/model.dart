

class ForgetPasswordModel{

  ForgetPasswordModel({
    required this.status,
    required this.data,
    required this.message,
    required this.isActive,
    required this.devMessage,

});

  String status;
  dynamic data;
  String message;
  bool isActive;
  int devMessage;

}

class ChangePasswordModel{


  ChangePasswordModel({
    required this.data,
    required this.status,
    required this.message
  });

  String status;
  String message;
  dynamic data;

  factory ChangePasswordModel.fromJson(Map<String,dynamic> json)=>ChangePasswordModel(
    data:json["data"],
    status: json["status"]??'',
    message: json["message"]??'',
  );
}
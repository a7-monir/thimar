part of 'bloc.dart';
class LoginModel{
  late String message,status;
 late Data data;

  LoginModel.fromJson(Map<String,dynamic> json){
    data = Data.fromJson(json["data"] ?? '');
    message =json['message'??''];
    status =json['status'??''];
  }
}
class Data {
  late String fullname, phone, email, image,userType,token;
  late int id, isBan,unreadNotifications,userCartCount;
  late bool isActive;
  late Country country;
  late City city;
  late dynamic identityNumber;

   Data.fromJson(Map<String,dynamic> json){
    id= json['id'] ??0 ;
    fullname=json['fullname']??'';
    phone= json['phone'] ??'' ;
    email= json['email']??'';
    image= json['image']??'';
    isBan= json['isBan']??0;
    isActive= json['isActive'] ?? false;
    unreadNotifications= json['unreadNotifications']??0;
    userType= json['userType'] ?? '';
    token= json['token'] ?? '';
    country= Country.fromJson(json['country']??{});
    city= City.fromJson(json['city']??{});
    identityNumber= json['identityNumber'] ?? 0;
    userCartCount= json['userCartCount'] ?? 0;
  }
}

class City {
 late dynamic id;
  late String name;

  City.fromJson(Map<String, dynamic> json) {
    id= json["id"] ?? 0;
    name= json["name"]??'';
  }
}

class Country {
  late dynamic id;
  late String name;
  late String nationality;
  late String key;
  late String flag;

  Country.fromJson(Map<String, dynamic> json){
    id =json["id"] ?? 1;
    name=json["name"]??'';
    nationality= json["nationality"]??'';
    key= json["key"]??'';
    flag= json["flag"]??'';
  }
}
import 'dart:convert';

import 'package:thimar/core/logic/cache_helper.dart';
import 'package:thimar/core/logic/helper_methods.dart';
import 'package:thimar/main.dart';

import '../screens/auth/login.dart';

class Users {

  late String fullname, phone, email, image,userType,token,cityName,deviceToken;
  late int id, isBan,unreadNotifications,userCartCount;
  late bool isActive;
  late Country country;
  late City city;
  late dynamic identityNumber;

  static final i = Users._();
  Users._(){
    fromJson();
  }
 fromJson([Map<String,dynamic>? json]){


    Map<String,dynamic> data = json ?? jsonDecode(preferences.getString('user')??'{}' );


    id= data['id'] ??0 ;
    fullname=data['fullname']??'';
    deviceToken=data['deviceToken']??'';
    cityName=data['cityName']??'';
    phone= data['phone'] ??'' ;
    email= data['email']??'';
    image= data['image']??'';
    isBan= data['isBan']??0;
    isActive= data['isActive'] ?? false;
    unreadNotifications= data['unreadNotifications']??0;
    userType= data['userType'] ?? '';
    token= data['token'] ?? '';
    country= Country.fromJson(data['country']??{});
    city= City.fromJson(data['city']??{});
    identityNumber= data['identityNumber'] ?? 0;
    userCartCount= data['userCartCount'] ?? 0;

  }
  Map<String,dynamic> toJson() {
    return {
      'id':id,
      'fullname':fullname,
      'deviceToken':deviceToken,
      'cityName':cityName,
      'phone':phone,
      'email':email,
      'isBan':isBan,
      'isActive':isActive,
      'unreadNotifications':unreadNotifications,
      'userType':userType,
      'token':token,
      'country':country,
      'city':city,
      'identityNumber':identityNumber,
      'userCartCount':userCartCount

    };
  }


  save (){
    preferences.setString("user", jsonEncode(toJson()));
  }
  Future clear()async{
    await preferences.remove("user");
    fromJson();
    navigateTo(LoginView());

  }


}
class City {
  late dynamic id;
  late String name;

  City.fromJson(Map<String, dynamic> json) {
    id= json["id"] ?? 0;
    name= json["name"]??'';
  }
  Map<String,dynamic> toJson() {
    return {
      'id':id,
      'name':name,

    };
  }

}

class Country {
  late dynamic id;
  late String name;
  late String nationality;
  late String key;
  late String flag;

  Country.fromJson(Map<String, dynamic> json){
    id = json["id"] ?? 1;
    name = json["name"] ?? '';
    nationality = json["nationality"] ?? '';
    key = json["key"] ?? '';
    flag = json["flag"] ?? '';
  }
  Map<String,dynamic> toJson() {
    return {
      'id':id,
      'name':name,
      'nationality':nationality,
      'key':key,
      'flag':flag,

    };
  }
}


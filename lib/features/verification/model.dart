part of 'bloc.dart';
class VerificationModel{
  late Data data;

  VerificationModel.fromJson(Map<String,dynamic>json)
      {data= Data.fromJson(json["data"]);}
     
}

class Data {
  late int id,unreadNotifications,userCartCount;
  late String fullname,phone, email, image,userType,token;
  late bool isBan, isActive;
  late Country country;
  late City city;
  late dynamic identityNumber;


   Data.fromJson(Map<String, dynamic> json)
  {
    id= json["id"]??0;
    fullname= json["fullname"]??'';
    phone= json["phone"]??0;
    email= json["email"]??'';
    image= json["image"]??'';
    isBan= json["is_ban"]==1;
    isActive= json["is_active"]??false;
    unreadNotifications= json["unread_notifications"]??0;
    userType= json["user_type"]??'';
    token= json["token"]??'';
    country= Country.fromJson(json["country"]);
    city= City.fromJson(json["city"]);
  identityNumber= json["identity_number"];
  userCartCount= json["user_cart_count"]??0;
  }




}
class City {

 late String id;
  late String name;

  City.fromJson(Map<String, dynamic> json)

  {id= json["id"];
    name= json["name"];}

}

class Country {

  late int id;
  late String name, nationality, key, flag;

  Country.fromJson(Map<String, dynamic> json)
  { id= json["id"];
    name= json["name"];
    nationality= json["nationality"];
  key= json["key"];
  flag= json["flag"];}

}


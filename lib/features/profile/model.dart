part of 'bloc.dart';

class ProfileModel {
  late final Data list;


  ProfileModel.fromJson(Map<String, dynamic> json){
    list = Data.fromJson(json['data']??{});
  }

}

class Data {

  late final int id;
  late final String fullname;
  late final String phone;
  late final String image;
  late final City city;
  late final int isVip;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    fullname = json['fullname']??'';
    phone = json['phone']??'';
    image = json['image']??'';
    city = City.fromJson(json['city']??{});
    isVip = json['is_vip']??0;
  }

}

class City {
  late final int id;
  late final String name;

  City.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    name = json['name']??'';
  }


}
part of 'bloc.dart';

class ContactData {
  late final ContactModel data;


  ContactData.fromJson(Map<String, dynamic> json){
    data = ContactModel.fromJson(json['data']??{});
  }

}

class ContactModel {

  late final String phone, email, whatsapp,location;
  late final Social social;
  late final double lat, lng;


  ContactModel.fromJson(Map<String, dynamic> json){
    phone = json['phone']??'';
    email = json['email']??'';
    whatsapp = json['whatsapp']??'';
    social = Social.fromJson(json['social']??{});
    lat = json['lat']??0.0;
    lng = json['lng']??0.0;
    location = json['location']??'';
  }

}

class Social {
  late final String facebook, twitter, instagram;

  Social.fromJson(Map<String, dynamic> json){
    facebook = json['facebook']??'';
    twitter = json['twitter']??'';
    instagram = json['instagram']??'';
  }

}
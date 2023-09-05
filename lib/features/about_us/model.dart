part of 'bloc.dart';

class AboutModel {

  late final Data list;

  AboutModel.fromJson(Map<String, dynamic> json){
    list = Data.fromJson(json['data']??{});
  }
}

class Data {
  late final String about;

  Data.fromJson(Map<String, dynamic> json){
    about = json['about']??'';
  }
}
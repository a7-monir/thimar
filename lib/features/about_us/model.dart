part of 'bloc.dart';

class AboutData {

  late final AboutModel model;

  AboutData.fromJson(Map<String, dynamic> json){
    model = AboutModel.fromJson(json['data']??{});
  }
}

class AboutModel {
  late final String about;

  AboutModel.fromJson(Map<String, dynamic> json){
    about = json['about']??'';
  }
}
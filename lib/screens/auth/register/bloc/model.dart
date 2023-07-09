

import 'dart:convert';

import '../../login/bloc/model.dart';


class RegisterModel{

  RegisterModel({
    required this.status,
    required this.data,
    required this.message,
    required this.devMessage,
  });

  String status;
  dynamic data;
  String message;
  int devMessage;

  factory RegisterModel.fromJson(Map<String,dynamic> json)=>RegisterModel(
    status: json["status"],
    data: json["data"],
    message: json["message"],
    devMessage: json["dev_message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "message": message,

  };



}

class CityDataModel {
  String? status;
  String? message;
  List<City>? data;
  CityDataModel({this.data, this.message, this.status});
  factory CityDataModel.fromJson(Map<String, dynamic> json) => CityDataModel(
    status: json["status"] ?? "",
    message: json["message"] ?? "",
    data: json["data"] == null
        ? null
        : List<City>.from(json["data"].map((x) => City.fromJson(x))),
  );
}

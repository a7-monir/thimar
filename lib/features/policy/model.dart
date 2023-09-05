part of 'bloc.dart';

class PolicyModel {
  late final Data list;

  PolicyModel.fromJson(Map<String, dynamic> json){
    list = Data.fromJson(json['data']);

  }
}

class Data {
  late final String policy;

  Data.fromJson(Map<String, dynamic> json){
    policy = json['policy']??'';
  }
}
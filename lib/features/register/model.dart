part of 'bloc.dart';


class RegisterModel{
  late String message,status;
  late dynamic data;
  late int devMessage;

 RegisterModel.fromJson(Map<String,dynamic> json)
  {
    data= json["data"]??{};
    devMessage= json["dev_message"];
    message =json['message'??''];
    status =json['status'??''];
  }
}

class CityDataModel {

  List<City>? list;
  CityDataModel({this.list, });
  CityDataModel.fromJson(Map<String, dynamic> json)
  {
    list= json["data"] == null
        ? null
        : List<City>.from(json["data"].map((x) => City.fromJson(x)));
  }

}

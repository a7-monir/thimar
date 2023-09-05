part of 'bloc.dart';
class SliderModel {

  late List<Datum> list;

  SliderModel.fromJson(Map<String, dynamic> json) {
    list=List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
  }

}

class Datum {

  late int id;
  late String media;

  Datum.fromJson(Map<String, dynamic> json)
  {
    id= json["id"];
    media= json["media"];
  }
}

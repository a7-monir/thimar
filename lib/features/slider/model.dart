part of 'bloc.dart';
class SliderData {

  late List<SliderModel> list;

  SliderData.fromJson(Map<String, dynamic> json) {
    list=List<SliderModel>.from(json["data"].map((x) => SliderModel.fromJson(x)));
  }

}

class SliderModel {

  late int id;
  late String media;

  SliderModel.fromJson(Map<String, dynamic> json)
  {
    id= json["id"];
    media= json["media"];
  }
}

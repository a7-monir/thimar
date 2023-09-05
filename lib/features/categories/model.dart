part of 'bloc.dart';
class CategoriesModel{
  late List<Data> list;

   CategoriesModel.fromJson(Map<String, dynamic> json) {
     list= List<Data>.from(json["data"].map((x) => Data.fromJson(x)));


   }

}

class Data {

  late int id;
  late String name, description, media;

   Data.fromJson(Map<String, dynamic> json) {
     id= json["id"]??0;
     name= json["name"]??'';
     description= json["description"]??'';
     media= json["media"]??'';}
}

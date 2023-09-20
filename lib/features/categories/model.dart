part of 'bloc.dart';
class CategoriesData{
  late List<CategoriesModel> list;

   CategoriesData.fromJson(Map<String, dynamic> json) {
     list= List<CategoriesModel>.from(json["data"].map((x) => CategoriesModel.fromJson(x)));


   }

}

class CategoriesModel {

  late int id;
  late String name, description, media;

   CategoriesModel.fromJson(Map<String, dynamic> json) {
     id= json["id"]??0;
     name= json["name"]??'';
     description= json["description"]??'';
     media= json["media"]??'';}
}

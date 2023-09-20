part of 'bloc.dart';


class CategoryProductData {
  late List<CategoryProductModel> list;


   CategoryProductData.fromJson(Map<String, dynamic> json)
   {
     list= List<CategoryProductModel>.from(json["data"].map((x) => CategoryProductModel.fromJson(x)));


   }


}

class CategoryProductModel {

  late int categoryId, id,priceBeforeDiscount,amount;
  late String title, description,code,mainImage;
  late dynamic price;
  late double discount;
  late bool isActive, isFavorite;
  late Unit unit;
  late List<Image> images;
  late DateTime createdAt;

  CategoryProductModel.fromJson(Map<String, dynamic> json)

  { categoryId= json["category_id"]??0;
    id= json["id"]??0;
    title= json["title"]??'';
    description= json["description"]??'';
    code= json["code"]??'';
    priceBeforeDiscount= json["price_before_discount"]??0;
    price= json["price"];
    discount= json["discount"].toDouble();
    amount= json["amount"]??0;
    isActive= json["is_active"]==1;
    isFavorite= json["is_favorite"]??false;
    unit= Unit.fromJson(json["unit"]);
    images= List<Image>.from(json["images"].map((x) => Image.fromJson(x)));
  mainImage= json["main_image"]??'';
    createdAt= DateTime.parse(json["created_at"]);}

}

class Image {

  late String name, url;

   Image.fromJson(Map<String, dynamic> json)
   {  name= json["name"]??'';
     url= json["url"]??'';}

}

class Unit {

  late int id;
  late String name, type;
 late DateTime createdAt, updatedAt;

 Unit.fromJson(Map<String, dynamic> json)
 {
   id= json["id"]??0;
   name= json["name"]??'';
   type= json["type"]??'';
 createdAt= DateTime.parse(json["created_at"]);
 updatedAt= DateTime.parse(json["updated_at"]);
 }

}


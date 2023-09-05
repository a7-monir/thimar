part of 'bloc.dart';
class GetProductsModel {
  late List<Data> list;
  late int userCartCount;
  late double maxPrice,minPrice;

   GetProductsModel.fromJson(Map<String, dynamic> json)
   {
     list= List<Data>.from(json["data"].map((x) => Data.fromJson(x)));
   userCartCount= json["user_cart_count"]??0;
   maxPrice= json["max_price"]?? 0.0 .toDouble();
   minPrice= json["min_price"]?? 0.0.toDouble();
   }


}
class Data {

  late int categoryId, id,priceBeforeDiscount,amount;
  late String title, description, code,mainImage;
  late double price, discount;
  late bool isActive, isFavorite;
  late Unit unit;
  late List<Image> images;
  late DateTime createdAt;

  Data.fromJson(Map<String, dynamic> json)
  {
    categoryId= json["category_id"]?? 0 ;
    id= json["id"] ?? 0 ;
    title= json["title"] ?? '' ;
    description= json["description"] ?? '';
    code= json["code"]??'';
    priceBeforeDiscount= json["price_before_discount"]??0;
    price= json["price"] .toDouble();
    discount= json["discount"]?? 0.0 .toDouble();
    amount= json["amount"]??0;
    isActive= json["is_active"]==1;
    isFavorite= json["is_favorite"] ?? false;
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

  Unit.fromJson(Map<String, dynamic> json){
    id = json["id"] ?? 0;
    name = json["name"] ?? '';
    type = json["type"] ?? '';
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
  }
}


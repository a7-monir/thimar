part of 'bloc.dart';
class FavoritesData {
  late final List<FavoritesModel> list;


  FavoritesData.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=>FavoritesModel.fromJson(e)).toList();

  }
}

class FavoritesModel {

  late final num categoryId,id,priceBeforeDiscount,price,amount;
  late final String title, description, code,mainImage,createdAt;
  late final num discount;
  late final bool isActive, isFavorite;
  late final Unit unit;
  late final List<Images> images;

  FavoritesModel.fromJson(Map<String, dynamic> json){
    categoryId = json['category_id']??0;
    id = json['id']??0;
    title = json['title']??'';
    description = json['description']??'';
    code = json['code']??'';
    priceBeforeDiscount = json['price_before_discount']??0;
    price = json['price']??0;
    discount = json['discount']??0;
    amount = json['amount']??0;
    isActive = json['is_active']==false;
    isFavorite = json['is_favorite']??false;
    unit = Unit.fromJson(json['unit']??{});
    images = List.from(json['images']??[]).map((e)=>Images.fromJson(e)).toList();
    mainImage = json['main_image']??'';
    createdAt = json['created_at']??'';
  }

}

class Unit {

  late final int id;
  late final String name, type, createdAt, updatedAt;

  Unit.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    name = json['name']??'';
    type = json['type']??'';
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
  }

}

class Images {
  late final String name, url;

  Images.fromJson(Map<String, dynamic> json){
    name = json['name']??'';
    url = json['url']??'';
  }

}
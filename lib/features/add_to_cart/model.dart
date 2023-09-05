part of 'bloc.dart';
class AddToCartModel {

  late final Data data;

  AddToCartModel.fromJson(Map<String, dynamic> json){

    data = Data.fromJson(json['data']);
  }

}

class Data {
  late final String title, image;
  late final int amount, deliveryCost, price;

  Data.fromJson(Map<String, dynamic> json){
    title = json['title']??'';
    image = json['image']??'';
    amount = json['amount']??0;
    deliveryCost = json['delivery_cost']??0;
    price = json['price']??0;
  }

}
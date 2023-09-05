part of 'bloc.dart';

class OrderModel {
  late final List<OrderData> list;



  OrderModel.fromJson(Map<String, dynamic> json){
    list = List.from(json['data']).map((e)=>OrderData.fromJson(e)).toList();


  }

}
class OrderData {
  late final int id,vipDiscountPercentage;
  late final String status, date, time, clientName, phone, location, deliveryPayer, payType, note;
  late final num  orderPrice,deliveryPrice,totalPrice;
  late final List<Products> products;
  late final bool isVip;

  OrderData.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    status = json['status']??'';
    date = json['date']??'';
    time = json['time']??'';
    orderPrice = json['order_price']??0;
    deliveryPrice = json['delivery_price']??0;
    totalPrice = json['total_price']??0;
    clientName = json['client_name']??'';
    phone = json['phone']??'';
    location = json['location']??'';
    deliveryPayer = json['delivery_payer']??'';
    products = List.from(json['products'] ?? []).map((e)=>Products.fromJson(e)).toList();
    payType = json['pay_type']??'';
    note = json['note']??'';
    isVip = json['is_vip']==1;
    vipDiscountPercentage = json['vip_discount_percentage']??0;
  }

}

class Products {
  late final String name, url;

  Products.fromJson(Map<String, dynamic> json){
    name = json['name']??'';
    url = json['url']??'';
  }
}





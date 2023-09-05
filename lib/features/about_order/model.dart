part of 'bloc.dart';

class AboutOrderModel {
  late final ProductData data;

  AboutOrderModel.fromJson(Map<String, dynamic> json){
    data = ProductData.fromJson(json['data']??{});
  }
}

class ProductData {
  late final String status, date,time,clientName,payType,deliveryPayer;
  late final num id, deliveryPrice,isVip, priceBeforeDiscount, discount, totalPrice,vipDiscount,orderPrice;
  late final Null phone, address,note;
  late final List<OrderDetailsProductModel> products;

  ProductData.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    status = json['status']??'';
    date = json['date']??'';
    time = json['time']??'';
    orderPrice = json['order_price']??0;
    deliveryPrice = json['delivery_price']??0;
    totalPrice = json['total_price']??0.0;
    clientName = json['client_name']??'';
    phone = null;
    address = null;
    products = List.from(json['products']??[]).map((e)=>OrderDetailsProductModel.fromJson(e)).toList();
    payType = json['pay_type']??'';
    note = null;
    deliveryPayer = json['delivery_payer']??'';
    isVip = json['is_vip']??false;
    vipDiscount = json['vip_discount']??false;
    priceBeforeDiscount = json['price_before_discount']??0;
    discount = json['discount']??0.0;
  }

}

class OrderDetailsProductModel {
  late final String name, url;

  OrderDetailsProductModel.fromJson(Map<String, dynamic> json){
    name = json['name']??'';
    url = json['url']??'';
  }
}
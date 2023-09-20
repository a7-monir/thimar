part of 'bloc.dart';

class AboutOrderData {
  late final ProductModel data;

  AboutOrderData.fromJson(Map<String, dynamic> json){
    data = ProductModel.fromJson(json['data']);
  }
}

class ProductModel {
  late final String status, date,time,clientName,payType,deliveryPayer;
  late final num id, deliveryPrice,isVip, priceBeforeDiscount, discount, totalPrice,vipDiscount,orderPrice;
  //late final String? phone, address,note;
  late final Null phone, address,note;
  late final List<OrderDetailsProductModel> products;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    status = json['status']??'';
    date = json['date']??'';
    time = json['time']??'';
    orderPrice = json['order_price']??0;
    deliveryPrice = json['delivery_price']??0;
    totalPrice = json['total_price']??0.0;
    clientName = json['client_name']??'';

    //phone = json['phone']??'';
    //address = json['address'];
    //note = json['note']??'';

    phone = null;
    note = null;
    address = null;
    products = List.from(json['products']??[]).map((e)=>OrderDetailsProductModel.fromJson(e)).toList();
    payType = json['pay_type']??'';

    deliveryPayer = json['delivery_payer']??'';
    isVip = json['is_vip']??false;
    vipDiscount = json['vip_discount']??false;
    priceBeforeDiscount = json['price_before_discount']??0;
    discount = json['discount']??0;
  }

}

class OrderDetailsProductModel {
  late final String name, url;

  OrderDetailsProductModel.fromJson(Map<String, dynamic> json){
    name = json['name']??'';
    url = json['url']??'';
  }
}
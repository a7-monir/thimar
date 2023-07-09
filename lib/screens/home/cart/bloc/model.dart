//
class CartModel {
  CartModel({
    required this.data,
    required this.totalPriceBeforeDiscount,
    required this.totalDiscount,
    required this.totalPriceWithVat,
    required this.deliveryCost,
    required this.freeDeliveryPrice,
    required this.vat,
    required this.isVip,
    required this.vipDiscountPercentage,
    required this.minVipPrice,
    required this.vipMessage,
    required this.status,
    required this.message,
  });
  late final List<Data> data;
  late final num totalPriceBeforeDiscount;
  late final num totalDiscount;
  late final num totalPriceWithVat;
  late final num deliveryCost;
  late final num freeDeliveryPrice;
  late final num vat;
  late final num isVip;
  late final num vipDiscountPercentage;
  late final num minVipPrice;
  late final String vipMessage;
  late final String status;
  late final String message;

  CartModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    totalPriceBeforeDiscount = json['total_price_before_discount'];
    totalDiscount = json['total_discount'];
    totalPriceWithVat = json['total_price_with_vat'];
    deliveryCost = json['delivery_cost'];
    freeDeliveryPrice = json['free_delivery_price'];
    vat = json['vat'];
    isVip = json['is_vip'];
    vipDiscountPercentage = json['vip_discount_percentage'];
    minVipPrice = json['min_vip_price'];
    vipMessage = json['vip_message'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['total_price_before_discount'] = totalPriceBeforeDiscount;
    _data['total_discount'] = totalDiscount;
    _data['total_price_with_vat'] = totalPriceWithVat;
    _data['delivery_cost'] = deliveryCost;
    _data['free_delivery_price'] = freeDeliveryPrice;
    _data['vat'] = vat;
    _data['is_vip'] = isVip;
    _data['vip_discount_percentage'] = vipDiscountPercentage;
    _data['min_vip_price'] = minVipPrice;
    _data['vip_message'] = vipMessage;
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.image,
    required this.amount,
    required this.priceBeforeDiscount,
    required this.discount,
    required this.price,
    required this.remainingAmount,
  });
  late final num id;
  late final String title;
  late final String image;
  late final num amount;
  late final num priceBeforeDiscount;
  late final num discount;
  late final num price;
  late final num remainingAmount;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    amount = json['amount'];
    priceBeforeDiscount = json['price_before_discount'];
    discount = json['discount'];
    price = json['price'];
    remainingAmount = json['remaining_amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['amount'] = amount;
    _data['price_before_discount'] = priceBeforeDiscount;
    _data['discount'] = discount;
    _data['price'] = price;
    _data['remaining_amount'] = remainingAmount;
    return _data;
  }
}


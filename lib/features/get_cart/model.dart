part of 'bloc.dart';

class CartModel{
  late final List<OrderData> list;
  late final num totalPriceBeforeDiscount, totalDiscount,totalPriceWithVat, deliveryCost, freeDeliveryPrice,vat, vipDiscountPercentage, minVipPrice;
  late final bool isVip;
  late final String vipMessage;

  CartModel.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? []).map((e) => OrderData.fromJson(e)).toList();
    totalPriceBeforeDiscount = json['total_price_before_discount'] ?? 0;
    totalDiscount = json['total_discount'];
    totalPriceWithVat = json['total_price_with_vat'];
    deliveryCost = json['delivery_cost'];
    freeDeliveryPrice = json['free_delivery_price'];
    vat = json['vat'];
    isVip = json['is_vip'] == 1;
    vipDiscountPercentage = json['vip_discount_percentage'];
    minVipPrice = json['min_vip_price'];
    vipMessage = json['vip_message'];
  }
}

class OrderData {
  late final int id, amount;
  late final String title, image;
  late final num, priceBeforeDiscount, discount, price, remainingAmount;

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    amount = json['amount'];
    priceBeforeDiscount = json['price_before_discount'];
    discount = json['discount'];
    price = json['price'];
    remainingAmount = json['remaining_amount'];
  }
}

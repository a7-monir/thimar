class AddToCartModel {
  AddToCartModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final Data data;

  AddToCartModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.title,
    required this.image,
    required this.amount,
    required this.deliveryCost,
    required this.price,
  });
  late final String title;
  late final String image;
  late final int amount;
  late final int deliveryCost;
  late final int price;

  Data.fromJson(Map<String, dynamic> json){
    title = json['title'];
    image = json['image'];
    amount = json['amount'];
    deliveryCost = json['delivery_cost'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['image'] = image;
    _data['amount'] = amount;
    _data['delivery_cost'] = deliveryCost;
    _data['price'] = price;
    return _data;
  }
}
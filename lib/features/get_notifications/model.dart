part of 'bloc.dart';
class NotificationModel {
  late final Data list;

  NotificationModel.fromJson(Map<String, dynamic> json){
    list = Data.fromJson(json['data']??{});
  }

}

class Data {
  late final int unreadnotificationsCount;
  late final List<Notifications> list;

  Data.fromJson(Map<String, dynamic> json){
    unreadnotificationsCount = json['unreadnotifications_count']??0;
    list = List.from(json['notifications']??[]).map((e)=>Notifications.fromJson(e)).toList();
  }

}

class Notifications {

  late final String id, title, body, notifyType,createdAt,readAt,image;
  late final Order order;
  late final Null offer, chat;

  Notifications.fromJson(Map<String, dynamic> json){
    id = json['id']??'';
    title = json['title']??'';
    body = json['body']??'';
    notifyType = json['notify_type']??'';
    order = Order.fromJson(json['order']??{});
    offer = null;
    chat = null;
    createdAt = json['created_at']??'';
    readAt = json['read_at']??'';
    image = json['image']??'';
  }


}

class Order {

  late final int orderId, clientId,driverId;
  late final Null orderType;
  late final String orderStatus;

  Order.fromJson(Map<String, dynamic> json){
    orderId = json['order_id']??0;
    clientId = json['client_id']??0;
    driverId = json['driver_id']??0;
    orderType = null;
    orderStatus = json['order_status']??'';
  }


}

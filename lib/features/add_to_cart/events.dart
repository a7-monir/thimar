part of 'bloc.dart';
class AddToCartEvents{}


class AddToCartStartEvent extends AddToCartEvents {
  int productId ;
  AddToCartStartEvent({required this.productId});

}
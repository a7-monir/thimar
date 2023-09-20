part of 'bloc.dart';
class CartEvents {}

class ShowCartStartEvent extends CartEvents {}
class AddCouponStartEvent extends CartEvents {
  final String code;
  AddCouponStartEvent({required this.code});
}

class DeleteStartEvens extends CartEvents{

  final int index;
  final num id;

  DeleteStartEvens({
    required this.index,
    required this.id
});

}
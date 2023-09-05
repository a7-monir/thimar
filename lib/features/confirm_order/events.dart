part of 'bloc.dart';
class ConfirmOrderEvents {}

class ConfirmOrderStartEvent extends ConfirmOrderEvents {

  String? addressId,date,time,note,payType;
  String? coupon,transactionId;
  ConfirmOrderStartEvent({
    required this.addressId,
    required this.date,
    required this.time,
    required this.note,
    required this.payType,
    this.transactionId,
    this.coupon,
  });
}

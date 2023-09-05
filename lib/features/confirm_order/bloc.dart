import 'package:bloc/bloc.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'states.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvents,ConfirmOrderStates> {
  ConfirmOrderBloc(this.serverGate) :super(ConfirmOrderStates()) {
    on<ConfirmOrderStartEvent>(confirmOrder);
  }

  //CartModel? model;
  final ServerGate serverGate;


  void confirmOrder(ConfirmOrderStartEvent event,
      Emitter<ConfirmOrderStates>emit) async {
    emit(ConfirmOrderLoadingState());
    final response = await serverGate.sendToServer(url: 'client/orders',
    body: {
      'address_id':event.addressId,
      'date':event.date,
      'time':event.time,
      'note':event.note,
      'pay_type':event.payType,
      'transaction_id':event.transactionId,
      'coupon_code':event.coupon,
    });
    if (response.success) {
      //model= CartModel.fromJson(response.response!.data);
      emit(ConfirmOrderSuccessState());
    }
    else {
      emit(ConfirmOrderFailedState(
          error: response.msg,
          errType: response.errType!));
    }
  }
}
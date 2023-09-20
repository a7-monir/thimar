
import 'package:bloc/bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';
part 'event.dart';
part 'model.dart';
part 'state.dart';

class OrderBloc extends Bloc<OrderEvent,OrderStates>{

  OrderBloc(this.serverGate) : super(OrderStates()) {
    on<ClientOrderStartEvent>(getData);
  }

  final ServerGate serverGate;

  void getData(ClientOrderStartEvent event, Emitter<OrderStates>emit )async {
    emit(ClientOrderLoadingState());
    final response = await serverGate.getFromServer(
        url: 'client/orders/${event.endPoint}');

    if (response.success) {
      final orderModel = OrderData.fromJson(response.response!.data);
      emit(ClientOrderSuccessState(model:orderModel));
    } else {
      emit(ClientOrderFailedState(
          statusCode: response.errType!, msg: response.msg));
    }
  }

}
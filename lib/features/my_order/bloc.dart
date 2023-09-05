
import 'package:bloc/bloc.dart';
import '../../../../helper/server_gate.dart';
part 'event.dart';
part 'model.dart';
part 'state.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{

  OrderBloc(this.serverGate) : super(OrderState()) {
    on<ClientOrderStartEvent>(getClientOrder);
  }

  final ServerGate serverGate;
  OrderModel? model;

  void getClientOrder(ClientOrderStartEvent event, Emitter<OrderState>emit )async {
    emit(ClientOrderLoadingState());
    final response = await serverGate.getFromServer(
        url: 'client/orders/${event.endPoint}');

    if (response.success) {
      model = OrderModel.fromJson(response.response!.data);
      emit(ClientOrderSuccessState());
    } else {
      emit(ClientOrderFailedState(
          errType: response.errType!, error: response.msg));
    }
  }

}

import 'package:bloc/bloc.dart';
import '../../../../../helper/server_gate.dart';
part 'event.dart';
part 'model.dart';
part 'state.dart';

class AboutOrderBloc extends Bloc<AboutOrderEvent,AboutOrderState>{

  AboutOrderBloc(this.serverGate) : super(AboutOrderState()) {

    on<AboutOrderStartEvent>(getOrderDetails);
    on<CancelOrderStartEvent>(cancelOrder);
    // on<FinishedOrderStartEvent>(getFinishedOrder);


  }

  final ServerGate serverGate;
  AboutOrderModel? model;

  void getOrderDetails(AboutOrderStartEvent event, Emitter<AboutOrderState>emit )async{
    emit(AboutOrderLoadingState());
    final response = await serverGate.getFromServer(url: 'client/orders/${event.id}');

    if(response.success){

      model = AboutOrderModel.fromJson(response.response!.data);
      emit(AboutOrderSuccessState());
    }else{
      emit(AboutOrderFailedState(errType: response.errType!, error: response.msg));
    }



  }


  void cancelOrder(CancelOrderStartEvent event, Emitter<AboutOrderState>emit)async{

    emit(CancelOrderLoadingState());

    final response =await serverGate.sendToServer(url: 'client/orders/${event.id}/cancel');
    if(response.success){

      emit(CancelOrderSuccessState());
    }else{
      emit(CancelOrderFailedState(errType: response.errType!, error: response.msg));}

  }

}
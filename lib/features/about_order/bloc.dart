
import 'package:bloc/bloc.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class AboutOrderBloc extends Bloc<AboutOrderEvent,AboutOrderState>{

  AboutOrderBloc(this.serverGate) : super(AboutOrderState()) {

    on<AboutOrderStartEvent>(getData);
    on<CancelOrderStartEvent>(cancelOrder);


  }

  final ServerGate serverGate;
  AboutOrderData?aboutOrderModel;


  void getData(AboutOrderStartEvent event, Emitter<AboutOrderState>emit )async{
    emit(AboutOrderLoadingState());
    final response = await serverGate.getFromServer(url: 'client/orders/${event.id}');

    if(response.success){

      final aboutOrderModel = AboutOrderData.fromJson(response.response!.data);

      emit(AboutOrderSuccessState(model:aboutOrderModel,));
    }else{
      emit(AboutOrderFailedState(statusCode: response.errType!, msg: response.msg));
    }



  }


  void cancelOrder(CancelOrderStartEvent event, Emitter<AboutOrderState>emit)async{

    emit(CancelOrderLoadingState());

    final response =await serverGate.sendToServer(url: 'client/orders/${event.id}/cancel');
    if(response.success){

      emit(CancelOrderSuccessState());
    }else{
      emit(CancelOrderFailedState(statusCode: response.errType!, msg: response.msg));}

  }

}
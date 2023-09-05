

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'states.dart';

class AddRateBloc extends Bloc<AddRateEvents,AddRateStates>{


  AddRateBloc(this.serverGate) : super(AddRateStates()) {
    on<AddRateStartEvents>(addRate);

  }

  final ServerGate serverGate ;
  final commentController=TextEditingController();
  
  void addRate(AddRateStartEvents event, Emitter<AddRateStates>emit)async{
    
    emit(AddRateLoadingState());
    
    final response = await serverGate.sendToServer(
      url: 'client/products/${event.ProductId}/rate',
    body: {
      'value': event.value,
      'comment':commentController.text,
    });
    if(response.success){

      emit(AddRateSuccessState());
    } else {
      emit(AddRateFailedState(type: response.errType!, error: response.msg));
    }
  }
}
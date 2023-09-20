

import 'package:bloc/bloc.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class FaqsBloc extends Bloc<FaqsEvents,FaqsStates>{

  FaqsBloc(this.serverGate):super(FaqsStates()){
    on<FaqsStartEvent>(getData);
  }


  final ServerGate serverGate;
  
  void getData(FaqsStartEvent event, Emitter<FaqsStates>emit) async {
    
    emit(FaqsLoadingState());
    
    final response= await serverGate.getFromServer(url: 'faqs');

    if(response.success){
     final FaqsModel= FaqsData.fromJson(response.response!.data);
      emit(FaqsSuccessState(model:FaqsModel,));
    }else{
      emit(FaqsFailedState(msg: response.msg, statusCode: response.errType!));
    }
  }
}
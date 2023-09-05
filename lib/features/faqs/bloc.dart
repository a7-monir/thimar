

import 'package:bloc/bloc.dart';
import '../../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class FaqsBloc extends Bloc<FaqsEvents,FaqsState>{

  FaqsBloc(this.serverGate):super(FaqsState()){
    on<FaqsStartEvent>(getFags);
  }

  FaqsModel? model ;
  final ServerGate serverGate;
  
  void getFags(FaqsStartEvent event, Emitter<FaqsState>emit) async {
    
    emit(FaqsLoadingState());
    
    final response= await serverGate.getFromServer(url: 'faqs');

    if(response.success){
      model= FaqsModel.fromJson(response.response!.data);
      emit(FaqsSuccessState());
    }else{
      emit(FaqsFailedState(error: response.msg, errType: response.errType!));
    }
  }
}
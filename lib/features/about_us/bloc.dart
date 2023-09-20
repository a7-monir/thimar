import 'package:bloc/bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';
part 'model.dart';
part 'events.dart';
part 'states.dart';

class AboutBloc extends Bloc<AboutEvents,AboutStates>{

  AboutBloc(this.serverGate):super(AboutLoadingState()){
    on<AboutStartEvent>(getData);
  }

  final ServerGate serverGate;

  void getData(AboutStartEvent event, Emitter<AboutStates>emit) async {

    emit(AboutLoadingState());

    final response= await serverGate.getFromServer(url: 'about');

    if(response.success){
      final aboutModel= AboutData.fromJson(response.response!.data);
      emit(AboutSuccessState(model: aboutModel,));
    }else{
      emit(AboutFailedState(error: response.msg, errType: response.errType!));
    }
  }
}
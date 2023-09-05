import 'package:bloc/bloc.dart';
import '../../../../../helper/server_gate.dart';
part 'model.dart';
part 'events.dart';
part 'states.dart';

class AboutBloc extends Bloc<AboutEvents,AboutStates>{

  AboutBloc(this.serverGate):super(AboutStates()){
    on<AboutStartEvent>(About);
  }

  AboutModel? model ;
  final ServerGate serverGate;

  void About(AboutStartEvent event, Emitter<AboutStates>emit) async {

    emit(AboutLoadingState());

    final response= await serverGate.getFromServer(url: 'about');

    if(response.success){
      model= AboutModel.fromJson(response.response!.data);
      emit(AboutSuccessState());
    }else{
      emit(AboutFailedState(error: response.msg, errType: response.errType!));
    }
  }
}
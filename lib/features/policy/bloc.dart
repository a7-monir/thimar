import 'package:bloc/bloc.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class PolicyBloc extends Bloc<PolicyEvents,PolicyStates>{

  PolicyBloc(this.serverGate):super(PolicyStates()){
    on<PolicyStartEvent>(getData);
  }

  final ServerGate serverGate;

  void getData(PolicyStartEvent event, Emitter<PolicyStates>emit) async {

    emit(PolicyLoadingState());

    final response= await serverGate.getFromServer(url: 'policy');

    if(response.success){
      final policyModel= PolicyData.fromJson(response.response!.data);
      emit(PolicySuccessState(model:policyModel));
    }else{
      emit(PolicyFailedState(msg: response.msg, statusCode: response.errType!));
    }
  }
}
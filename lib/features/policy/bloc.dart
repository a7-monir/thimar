import 'package:bloc/bloc.dart';
import '../../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class PolicyBloc extends Bloc<PolicyEvents,PolicyState>{

  PolicyBloc(this.serverGate):super(PolicyState()){
    on<PolicyStartEvent>(policy);
  }

  PolicyModel? model ;
  final ServerGate serverGate;

  void policy(PolicyStartEvent event, Emitter<PolicyState>emit) async {

    emit(PolicyLoadingState());

    final response= await serverGate.getFromServer(url: 'policy');

    if(response.success){
      model= PolicyModel.fromJson(response.response!.data);
      emit(PolicySuccessState());
    }else{
      emit(PolicyFailedState(error: response.msg, errType: response.errType!));
    }
  }
}
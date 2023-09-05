
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'states.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvents,ForgetPasswordState>{

  ForgetPasswordBloc(this.serverGate):super(ForgetPasswordState()){

    on<ForgetPasswordStartEvents>(ForgetPassword);
    
  }
  final phoneController = TextEditingController();
  final ServerGate serverGate;


  void ForgetPassword (ForgetPasswordEvents event,Emitter<ForgetPasswordState>emit)async {
  
  emit(ForgetPasswordLoadingState());
  
  final response = await serverGate.sendToServer(
      url: 'forget_password',
  body: {
        'phone':phoneController.text.trim()
  });
  if(response.success)
  {
    emit(ForgetPasswordSuccessState(
        phone: phoneController));
  }else{
    emit(ForgetPasswordFailState(
        type: response.errType!, error: response.msg));
  }
  }
}


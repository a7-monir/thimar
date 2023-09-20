
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'states.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvents,ForgetPasswordStates>{

  ForgetPasswordBloc(this.serverGate):super(ForgetPasswordStates()){

    on<ForgetPasswordStartEvents>(ForgetPassword);
    
  }
  final phoneController = TextEditingController();
  final ServerGate serverGate;


  void ForgetPassword (ForgetPasswordEvents event,Emitter<ForgetPasswordStates>emit)async {
  
  emit(ForgetPasswordLoadingState());
  
  final response = await serverGate.sendToServer(
      url: 'forget_password',
  body: {
        'phone':phoneController.text.trim()
  });
  if(response.success)
  {
    emit(ForgetPasswordSuccessState(
        phone: phoneController, msg: response.msg));
  }else{
    emit(ForgetPasswordFailState(
        statusCode: response.errType!, msg: response.msg));
  }
  }
}


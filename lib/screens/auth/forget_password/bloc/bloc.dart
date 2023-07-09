
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar/screens/auth/forget_password/bloc/events.dart';
import 'package:thimar/screens/auth/forget_password/bloc/states.dart';

import '../../../../helper/server_gate.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvents,ForgetPasswordState>{

  ForgetPasswordBloc():super(ForgetPasswordState()){

    on<ForgetPasswordStartEvents>(ForgetPassword);
    
  }
  final phoneController = TextEditingController();
  ServerGate serverGate = ServerGate();


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
        type: response.errType!.toInt(), error: response.msg.toString()));
  }
  }
}


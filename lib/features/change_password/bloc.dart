

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar/helper/toast.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'states.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvents,ChangePasswordState>{

  ChangePasswordBloc(this.serverGate):super(ChangePasswordState()){
    on<ChangePasswordStartEvents>(ChangePassword);

  }

  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  late String phone;
  late String code;


  final ServerGate serverGate;


  bool isDataValid(context){
    if(passwordController.text.trim().isNotEmpty){
      if(confirmPasswordController.text.trim().isNotEmpty){
        if(passwordController.text.trim() ==
            confirmPasswordController.text.trim()){
          return true;
        }else {
          Toast.show("passwordsNotMatched", context);
          return false;
        }
      }else {
        Toast.show("PleaseWriteYourConfirmPassword", context);
        return false;
      }
    }else {
      Toast.show("PleaseWriteYourPassword", context);
      return false;
    }
  }
  
  void ChangePassword (ChangePasswordStartEvents event,Emitter<ChangePasswordState>emit)async {

    emit(ChangePasswordLoadingState());


    final response =await serverGate.sendToServer(
        url: 'reset_password',
    body: {
          'phone':phone,
      'code':code,
      'password':passwordController.text,
    });
    if(response.success){
      emit(ChangePasswordSuccessState());
    }
    else{
      emit(ChangePasswordFailState(
          type: response.errType!, error: response.msg
      ));
    }
  }
}
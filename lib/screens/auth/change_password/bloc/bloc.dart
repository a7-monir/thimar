

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thimar/helper/toast.dart';
import 'package:thimar/screens/auth/change_password/bloc/events.dart';
import 'package:thimar/screens/auth/change_password/bloc/states.dart';

import '../../../../helper/server_gate.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvents,ChangePasswordState>{

  ChangePasswordBloc():super(ChangePasswordState()){
    on<ChangePasswordEvents>(ChangePassword);

  }

  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  late String phone;
  late String code;


  ServerGate serverGate = ServerGate();


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
  
  void ChangePassword (ChangePasswordEvents event,Emitter<ChangePasswordState>emit)async {

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
          type: response.errType!.toInt(), error: response.msg.toString()
      ));
    }
  }
}
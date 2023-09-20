

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/logic/server_gate.dart';
import '../../core/logic/toast.dart';

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
          showMessage("passwordsNotMatched");

          return false;
        }
      }else {
        showMessage("PleaseWriteYourConfirmPassword");
        return false;
      }
    }else {
      showMessage('PleaseWriteYourPassword');
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
      emit(ChangePasswordSuccessState(msg: response.msg));
    }
    else{
      emit(ChangePasswordFailState(
          statusCode: response.errType!, msg: response.msg
      ));
    }
  }
}
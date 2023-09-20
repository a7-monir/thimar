

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'states.dart';


class EditPasswordBloc extends Bloc<EditPasswordEvents,EditPasswordStates>{

  EditPasswordBloc(this.serverGate):super(EditPasswordStates()){
    on<EditPasswordStartEvents>(editPassword);

  }

  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  final ServerGate serverGate;



  void editPassword (EditPasswordStartEvents event,Emitter<EditPasswordStates>emit)async {

    emit(EditPasswordLoadingState());


    final response =await serverGate.sendToServer(
        url: 'edit_password',
        body: {
          'old_password':oldPasswordController.text,
          'password':newPasswordController.text,
          '_method':'PUT',
        });
    if(response.success){
      emit(EditPasswordSuccessState(msg: response.msg));
    }
    else{
      emit(EditPasswordFailState(
          statusCode: response.errType!, msg: response.msg
      ));
    }
  }
}
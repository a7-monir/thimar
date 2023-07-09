import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:thimar/screens/auth/register/bloc/model.dart';
import 'package:thimar/screens/auth/verification/bloc/events.dart';
import 'package:thimar/screens/auth/verification/bloc/model.dart';
import 'package:thimar/screens/auth/verification/bloc/states.dart';

import '../../../../helper/cache_helper.dart';
import '../../../../helper/server_gate.dart';

class VerificationBloc extends Bloc<VerificationEvents, VerificationState> {
  VerificationBloc() : super(VerificationState()) {
    on<VerificationStartEvents>(Verification);
    on<ResendCodeStartEvents>(ResendCode);
    on<CheckCodeStartEvents>(CheckCode);
  }

  final codeController = TextEditingController();
  late String phone;
  final counterController = CountDownController();
  double counter = 120;
  VerificationModel? model;
  // final phoneController = TextEditingController();

  ServerGate serverGate = ServerGate();

  void Verification(
      VerificationEvents event, Emitter<VerificationState> emit) async {
   // final deviceToken = await FirebaseMessaging.instance.getToken();
    //CacheHelper.setFCMToken(model!.data.token);
    emit(VerificationLoadingState());

    final response = await serverGate.sendToServer(
      url: 'verify',
      body: {
        'code': codeController.text,
        'phone': phone,
        'device_token': 'test',
        'type': 'ios'
      },
    );
    if (response.success) {
      emit(VerificationSuccessState());

    } else {
      emit(VerificationFailedState(
          type: response.errType!.toInt(), error: response.msg.toString()));
    }
  }

  void CheckCode(
      CheckCodeStartEvents event, Emitter<VerificationState> emit) async {
    emit(CheckCodeLoadingState());

    CustomResponse response =
        await serverGate.sendToServer(url: 'check_code', body: {
      'phone': phone,
      'code': codeController.text,
    });
    if(response.success){
      emit(CheckCodeSuccessState());

    }else{
      emit(CheckCodeFailedState(
          type: response.errType!.toInt(), error: response.msg.toString()));
    }
  }

  void ResendCode(
      ResendCodeStartEvents event, Emitter<VerificationState> emit) async {
    emit(ResendCodeLoadingState());

    CustomResponse response = await serverGate
        .sendToServer(url: 'resend_code', body: {"phone": phone});
    if (response.success) {

      emit(ResendCodeSuccessState());
    } else {
      emit(ResendCodeFailedState(
          errType: response.errType!.toInt(), error: response.msg.toString()));
    }
  }
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/server_gate.dart';

part 'events.dart';
part 'model.dart';
part 'states.dart';

class VerificationBloc extends Bloc<VerificationEvents, VerificationStates> {
  VerificationBloc(this.serverGate) : super(VerificationStates()) {
    on<VerificationStartEvents>(Verification);
    on<ResendCodeStartEvents>(ResendCode);
    on<CheckCodeStartEvents>(CheckCode);
  }

  final codeController = TextEditingController();
  late String phone;
  final counterController = CountDownController();
  double counter = 20;

  // final phoneController = TextEditingController();

  final ServerGate serverGate;

  void Verification(
      VerificationEvents event, Emitter<VerificationStates> emit) async {
   // final deviceToken = await FirebaseMessaging.instance.getToken();
    //CacheHelper.setFCMToken(model!.data.token);
    emit(VerificationLoadingState());
    final deviceToken = await FirebaseMessaging.instance.getToken() ?? "MOONir";
    print('+++++++++++++++++++++++++++++++++++++++++++');
    debugPrint(deviceToken);


    final response = await serverGate.sendToServer(
      url: 'verify',
      body: {
        'code': codeController.text,
        'phone': phone,
        'device_token': deviceToken,
        'type': Platform.operatingSystem
      },
    );
    if (response.success) {
      final verificationModel = VerificationData.fromJson(response.response!.data);
      print(response.response!.data);
      CacheHelper.setUserId(verificationModel.data.id);
      CacheHelper.setFullName(verificationModel.data.fullname);
      CacheHelper.setPhone(verificationModel.data.phone);
      CacheHelper.setEmail(verificationModel.data.email);
      CacheHelper.setImage(verificationModel.data.image);
      CacheHelper.setUnreadNotifications(verificationModel.data.unreadNotifications);
      CacheHelper.setUserType(verificationModel.data.userType);
      CacheHelper.setUserToken(verificationModel.data.token);
      CacheHelper.setCityName(verificationModel.data.city.name ?? "");
      CacheHelper.setCityId(verificationModel.data.city.id ?? "");
      CacheHelper.setUserCartCount(verificationModel.data.userCartCount);
      CacheHelper.setDeviceToken(deviceToken);
      emit(VerificationSuccessState(model: verificationModel, msg: response.msg));

    } else {
      emit(VerificationFailedState(
          statusCode: response.errType!, msg: response.msg));
    }
  }

  void CheckCode(
      CheckCodeStartEvents event, Emitter<VerificationStates> emit) async {
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
          statusCode: response.errType!, msg: response.msg));
    }
  }

  void ResendCode(
      ResendCodeStartEvents event, Emitter<VerificationStates> emit) async {
    emit(ResendCodeLoadingState());

    CustomResponse response = await serverGate
        .sendToServer(url: 'resend_code', body: {"phone": phone});
    if (response.success) {

      emit(ResendCodeSuccessState());
    } else {
      emit(ResendCodeFailedState(
          statusCode: response.errType!, msg: response.msg));
    }
  }
}

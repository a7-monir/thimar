import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../helper/cache_helper.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class VerificationBloc extends Bloc<VerificationEvents, VerificationState> {
  VerificationBloc(this.serverGate) : super(VerificationState()) {
    on<VerificationStartEvents>(Verification);
    on<ResendCodeStartEvents>(ResendCode);
    on<CheckCodeStartEvents>(CheckCode);
  }

  final codeController = TextEditingController();
  late String phone;
  final counterController = CountDownController();
  double counter = 20;
  VerificationModel? model;
  // final phoneController = TextEditingController();

  final ServerGate serverGate;

  void Verification(
      VerificationEvents event, Emitter<VerificationState> emit) async {
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
      model = VerificationModel.fromJson(response.response!.data);
      print(response.response!.data);
      CacheHelper.setUserId(model!.data.id);
      CacheHelper.setFullName(model!.data.fullname);
      CacheHelper.setPhone(model!.data.phone);
      CacheHelper.setEmail(model!.data.email);
      CacheHelper.setImage(model!.data.image);
      CacheHelper.setUnreadNotifications(model!.data.unreadNotifications);
      CacheHelper.setUserType(model!.data.userType);
      CacheHelper.setUserToken(model!.data.token);
      CacheHelper.setCityName(model!.data.city.name ?? "");
      CacheHelper.setCityId(model!.data.city.id ?? "");
      CacheHelper.setUserCartCount(model!.data.userCartCount);
      CacheHelper.setDeviceToken(deviceToken);
      emit(VerificationSuccessState());

    } else {
      emit(VerificationFailedState(
          type: response.errType!, error: response.msg));
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
          type: response.errType!, error: response.msg));
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
          errType: response.errType!, error: response.msg));
    }
  }
}

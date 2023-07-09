import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/helper/cache_helper.dart';
import 'package:thimar/screens/auth/login/bloc/events.dart';
import 'package:thimar/screens/auth/login/bloc/model.dart';
import 'package:thimar/screens/auth/login/bloc/states.dart';

import '../../../../helper/server_gate.dart';


class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginStartEvents>(Login);
  }

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  LoginModel? model;

  ServerGate serverGate = ServerGate();

  void Login(LoginStartEvents event, Emitter<LoginState> emit) async {
   final deviceToken = await FirebaseMessaging.instance.getToken();
   CacheHelper.setFCMToken(deviceToken!);
   debugPrint(deviceToken);
    emit(LoginLoadingState());

    final response =
        await serverGate.sendToServer(url: 'login',
            body: {
      'phone': phoneController.text.trim(),
      'password': passwordController.text.trim(),
      'device_token': deviceToken,
      'type': 'ios',
      'user_type': 'client',
    });
    if (response.success) {
      model= LoginModel.fromJson(response.response!.data);
      print(response.response!.data);
      CacheHelper.setUserId(model!.data.id);
      CacheHelper.setFullName(model!.data.fullname);
      CacheHelper.setPhone(model!.data.phone);
      CacheHelper.setEmail(model!.data.email);
      CacheHelper.setImage(model!.data.image);
      CacheHelper.setUnreadNotifications(model!.data.unreadNotifications);
      CacheHelper.setUserType(model!.data.userType);
      CacheHelper.setUserToken(model!.data.token);
      CacheHelper.setCityName(model?.data.city?.name??"");
      CacheHelper.setCityId(model!.data.city?.id??"");
      CacheHelper.setUserCartCount(model!.data.userCartCount);
      emit(LoginSuccessState());


    } else {
      emit(LoginFailState(
          type: response.statusCode,
          error: response.msg.toString()));
    }
  }
}

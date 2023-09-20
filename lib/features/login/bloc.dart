import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/logic/server_gate.dart';
import '../../core/logic/toast.dart';

part 'events.dart';
part 'model.dart';
part 'states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc(this.serverGate) : super(LoginStates()) {
    on<LoginStartEvents>(Login);
  }

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();


  final ServerGate serverGate;

  void Login(LoginStartEvents event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());

    final deviceToken = await FirebaseMessaging.instance.getToken() ;
    print('+++++++++++++++++++++++++++++++++++++++++++');
    debugPrint(deviceToken);

    final response = await serverGate.sendToServer(url: 'login', body: {
      'phone': phoneController.text.trim(),
      'password': passwordController.text.trim(),
      'device_token': deviceToken,
      'type': Platform.operatingSystem,
      'user_type': 'client',
    });
    if (response.success) {
      final loginModel = LoginData.fromJson(response.response!.data);
      print(response.response!.data);
      CacheHelper.setUserId(loginModel.data.id);
      CacheHelper.setFullName(loginModel.data.fullname);
      CacheHelper.setPhone(loginModel.data.phone);
      CacheHelper.setEmail(loginModel.data.email);
      CacheHelper.setImage(loginModel.data.image);
      CacheHelper.setUnreadNotifications(loginModel.data.unreadNotifications);
      CacheHelper.setUserType(loginModel.data.userType);
      CacheHelper.setUserToken(loginModel.data.token);
      CacheHelper.setCityName(loginModel.data.city.name ?? "");
      CacheHelper.setCityId(loginModel.data.city.id ?? "");
      CacheHelper.setUserCartCount(loginModel.data.userCartCount);
      CacheHelper.setDeviceToken(deviceToken!);

      CacheHelper.setUserType('client');
      emit(LoginSuccessState(msg: response.msg, model: loginModel));
    } else {
      emit(LoginFailState(statusCode: response.statusCode, msg: response.msg));
    }
  }
}

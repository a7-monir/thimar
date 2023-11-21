import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/models/user.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/logic/server_gate.dart';
import '../../core/logic/toast.dart';

part 'events.dart';
// part 'model.dart';
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

      print('++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print(response.response!.data["data"]);

      Users.i.fromJson(response.response!.data["data"]);
      Users.i.save();

      emit(LoginSuccessState(msg: response.msg,));
    } else {
      emit(LoginFailState(statusCode: response.statusCode, msg: response.msg));
    }
  }
}

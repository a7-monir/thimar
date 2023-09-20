import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/server_gate.dart';

part 'events.dart';
part 'states.dart';

class LogoutBloc extends Bloc<LogoutEvents, LogoutStates> {
  LogoutBloc(this.serverGate) : super(LogoutStates()) {
    on<LogoutStartEvents>(Logout);
  }

  final ServerGate serverGate ;

  void Logout(LogoutStartEvents event, Emitter<LogoutStates> emit) async {
    emit(LogoutLoadingState());
print('-==-=------ ${CacheHelper.getDeviceToken()}');
    final response = await serverGate.sendToServer(url: 'logout',
        body: {
          'device_token': CacheHelper.getDeviceToken(),
          'type':Platform.operatingSystem,
        });
    if (response.success) {
      CacheHelper.clear();
      emit(LogoutSuccessState(msg: response.msg));

    } else {
      emit(LogoutFailState(
          statusCode: response.statusCode,
          msg: response.msg));
    }
  }
}

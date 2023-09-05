import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/helper/cache_helper.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'states.dart';

class LogoutBloc extends Bloc<LogoutEvents, LogoutState> {
  LogoutBloc(this.serverGate) : super(LogoutState()) {
    on<LogoutStartEvents>(Logout);
  }

  final ServerGate serverGate ;

  void Logout(LogoutStartEvents event, Emitter<LogoutState> emit) async {
    emit(LogoutLoadingState());
print('-==-=------ ${CacheHelper.getDeviceToken()}');
    final response = await serverGate.sendToServer(url: 'logout',
        body: {
          'device_token': CacheHelper.getDeviceToken(),
          'type':Platform.operatingSystem,
        });
    if (response.success) {
      CacheHelper.clear();
      emit(LogoutSuccessState());

    } else {
      emit(LogoutFailState(
          type: response.statusCode,
          error: response.msg));
    }
  }
}

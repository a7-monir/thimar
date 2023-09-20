import 'package:bloc/bloc.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsStates> {
  NotificationsBloc(this.serverGate) : super(NotificationsStates()) {
    on<NotificationsStartEvent>(getData);

    //on<NotificationsStartEvent>(GetProducts);
  }

  final ServerGate serverGate;


  void getData(NotificationsStartEvent event,
      Emitter<NotificationsStates> emit) async {
    emit(NotificationsLoadingState());

    final response = await serverGate.getFromServer(url: 'notifications',);

    if (response.success) {
      final notificationsModel = NotificationData.fromJson(response.response!.data);

      emit(NotificationsSuccessState(model:notificationsModel));
    } else {
      emit(NotificationsFailedState(
          msg: response.msg, statusCode: response.errType!));
    }
  }
}

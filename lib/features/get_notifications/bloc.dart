import 'package:bloc/bloc.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsStates> {
  NotificationsBloc(this.serverGate) : super(NotificationsStates()) {
    on<NotificationsStartEvent>(GetNotifications);

    //on<NotificationsStartEvent>(GetProducts);
  }

  final ServerGate serverGate;

  NotificationModel? model;

  void GetNotifications(NotificationsStartEvent event,
      Emitter<NotificationsStates> emit) async {
    emit(NotificationsLoadingState());

    final response = await serverGate.getFromServer(url: 'notifications',);

    if (response.success) {
      model = NotificationModel.fromJson(response.response!.data);

      emit(NotificationsSuccessState());
    } else {
      emit(NotificationsFailedState(
          error: response.msg, errType: response.errType!));
    }
  }
}

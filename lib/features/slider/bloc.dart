import 'package:bloc/bloc.dart';
import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class SliderBloc extends Bloc<SliderEvents, SliderStates> {
  SliderBloc(this.serverGate) : super(SliderStates()) {
    on<SliderStartEvent>(getData);
  }
  final ServerGate serverGate;






  void getData(SliderStartEvent event, Emitter<SliderStates> emit) async {
    emit(SliderLoadingState());

    final response = await serverGate.getFromServer(url: 'sliders');
    if (response.success) {
      final sliderModel = SliderData.fromJson(response.response!.data);
      emit(SliderSuccessState(model:sliderModel));
    } else {
      emit(SliderFailedState(
          msg: response.msg, statusCode: response.errType!));
    }
  }





}

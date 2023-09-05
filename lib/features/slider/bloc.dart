import 'package:bloc/bloc.dart';
import '../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class SliderBloc extends Bloc<SliderEvents, SliderState> {
  SliderBloc(this.serverGate) : super(SliderState()) {
    on<SliderStartEvent>(Slider);
  }
  final ServerGate serverGate;
  SliderModel? sliderModel;





  void Slider(SliderStartEvent event, Emitter<SliderState> emit) async {
    emit(SliderLoadingState());

    final response = await serverGate.getFromServer(url: 'sliders');
    // final model = SliderModel.fromJson(response.response!.data);
    if (response.success) {
      sliderModel = SliderModel.fromJson(response.response!.data);
      emit(SliderSuccessState());
    } else {
      emit(SliderFailedState(
          error: response.msg, errType: response.errType!));
    }
  }





}

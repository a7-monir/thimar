import 'package:bloc/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_add_to_cart/model.dart';
import 'package:thimar/mutual_bloc/bloc_categories/model.dart';
import 'package:thimar/mutual_bloc/bloc_get_products/model.dart';
import 'package:thimar/mutual_bloc/bloc_slider/events.dart';
import 'package:thimar/mutual_bloc/bloc_slider/states.dart';
import '../../helper/server_gate.dart';
import 'model.dart';

class SliderBloc extends Bloc<SliderEvents, SliderState> {
  SliderBloc() : super(SliderState()) {
    on<SliderStartEvent>(Slider);
  }

  ServerGate serverGate = ServerGate();
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
          error: response.msg.toString(), errType: response.errType!.toInt()));
    }
  }





}

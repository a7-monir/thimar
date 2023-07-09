
import 'package:bloc/bloc.dart';
import 'package:thimar/screens/home/show_product/bloc/states.dart';

import '../../../../helper/server_gate.dart';
import 'events.dart';
import 'model.dart';

class ShowProductBloc extends Bloc<ShowProductEvents,ShowProductState> {
  ShowProductBloc() :super (ShowProductState()) {
    on<ShowProductStartEvent>(getShowProduct);
  }

  ShowProductModel? model;
  ServerGate serverGate = ServerGate();

  void getShowProduct(ShowProductStartEvent event , Emitter<ShowProductState>emit) async {

    
    emit (ShowProductLoadingState());
    
    final response = await serverGate.getFromServer(url: 'products/${event.productsId}');

    if(response.success){
      model= ShowProductModel.fromJson(response.response!.data);
      emit (ShowProductSuccessState());
    } else{
      emit(ShowProductFailedState(
          error: response.msg.toString(),
          errType: response.errType!.toInt()));
    }
  }

}
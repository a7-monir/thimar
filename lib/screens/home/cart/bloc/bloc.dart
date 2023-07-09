
import 'package:bloc/bloc.dart';
import 'package:thimar/helper/cache_helper.dart';
import 'package:thimar/screens/home/cart/bloc/events.dart';
import 'package:thimar/screens/home/cart/bloc/model.dart';
import 'package:thimar/screens/home/cart/bloc/states.dart';

import '../../../../helper/server_gate.dart';

class ShowCartBloc extends Bloc<ShowCartEvents,ShowCartState>{
  ShowCartBloc():super(ShowCartState()){
    on<ShowCartStartEvent>(showCart);
  }
  CartModel? model;
  ServerGate serverGate = ServerGate();

  void showCart(ShowCartStartEvent event, Emitter<ShowCartState>emit)async{
    emit(ShowCartLoadingState());
    final response = await serverGate.getFromServer(url: 'client/cart/');
    if(response.success){
      model= CartModel.fromJson(response.response!.data);
      emit(ShowCartSuccessState());
    }
    else{
      emit(ShowCartFailedState(
          error: response.msg.toString(),
          errType: response.errType!.toInt()));
    }

  }
}
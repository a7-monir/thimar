

import 'package:bloc/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_add_to_cart/events.dart';
import 'package:thimar/mutual_bloc/bloc_add_to_cart/states.dart';

import '../../helper/server_gate.dart';
import 'model.dart';

class AddToCartBloc extends Bloc<AddToCartEvents,AddToCartState>{

  AddToCartBloc() :super(AddToCartState()) {
    on<AddToCartStartEvent>(AddToCart);
  }
  ServerGate serverGate = ServerGate();
  AddToCartModel? addToCartModel;
  late int productId ;

  void AddToCart(AddToCartStartEvent event, Emitter<AddToCartState> emit) async {
    emit(AddToCartLoadingState());

    final response = await serverGate.sendToServer(
        url: 'client/cart',
        body: {
          'product_id': productId,
          'amount': 1
        });

    if(response.success){
      addToCartModel= AddToCartModel.fromJson(response.response!.data);
      emit(AddToCartSuccessState());

    }else(
        emit(
            AddToCartFailedState(
                type:response.errType!.toInt(), error: response.msg.toString()) )
    );

  }
}
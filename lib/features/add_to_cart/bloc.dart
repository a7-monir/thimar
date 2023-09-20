

import 'package:bloc/bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'states.dart';

class AddToCartBloc extends Bloc<AddToCartEvents,AddToCartState>{

  AddToCartBloc(this.serverGate) :super(AddToCartState()) {
    on<AddToCartStartEvent>(AddToCart);
  }
  final ServerGate serverGate;

  // AddToCartModel? addToCartModelCartModel;
   int? productId ;

  void AddToCart(AddToCartStartEvent event, Emitter<AddToCartState> emit) async {
    emit(AddToCartLoadingState());

    final response = await serverGate.sendToServer(
        url: 'client/cart',
        body: {
          'product_id': productId,
          'amount': 1
        });

    if(response.success){
      // addToCartModel= AddToCartModel.fromJson(response.response!.data);
      emit(AddToCartSuccessState(msg: response.msg));

    }else(
        emit(
            AddToCartFailedState(
                type:response.errType!, msg: response.msg) )
    );

  }
}
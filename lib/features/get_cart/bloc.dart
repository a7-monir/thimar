
import 'package:bloc/bloc.dart';

import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class ShowCartBloc extends Bloc<CartEvents,CartStates>{
  ShowCartBloc(this.serverGate):super(CartStates()){
    on<ShowCartStartEvent>(showCart);
    on<DeleteStartEvens>(deleteFromCart);
    on<AddCouponStartEvent>(addCoupon);
  }
  CartModel? model;
  final ServerGate serverGate;

  void showCart(ShowCartStartEvent event, Emitter<CartStates>emit)async{
    emit(ShowCartLoadingState());
    final response = await serverGate.getFromServer(url: 'client/cart');
    if(response.success){
      model= CartModel.fromJson(response.response!.data);
      emit(ShowCartSuccessState());
    }
    else{
      emit(ShowCartFailedState(
          error: response.msg,
          errType: response.errType!));
    }

  }

  void deleteFromCart(DeleteStartEvens event, Emitter<CartStates>emit)async{

    emit(DeleteFromCartLoadingState());
    final response = await serverGate.deleteFromServer(url: 'client/cart/delete_item/${event.id}');
    if (response.success){
      model!.list.removeAt(event.index);
      emit(DeleteFromCartSuccessState());

    }else{
      emit(DeleteFromCartFailedState(
          error: response.msg,
          errType: response.errType!));
    }
    
  }

  void addCoupon(AddCouponStartEvent event, Emitter<CartStates>emit)async{
    emit(AddCouponLoadingState());
    final response = await serverGate.sendToServer(url: 'client/cart/apply_coupon',
    body: {
      "code":event.code

    });
    if(response.success){
      emit(AddCouponSuccessState());

    } else{
      emit(AddCouponFailedState(
          error: response.msg,
          errType: response.errType!));
    }
  }
}
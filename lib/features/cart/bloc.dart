
import 'package:bloc/bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';

part 'events.dart';
part 'model.dart';
part 'states.dart';

class ShowCartBloc extends Bloc<CartEvents,CartStates>{
  ShowCartBloc(this.serverGate):super(CartStates()){
    on<ShowCartStartEvent>(getData);
    on<DeleteStartEvens>(deleteFromCart);
    on<AddCouponStartEvent>(addCoupon);

  }

  final ServerGate serverGate;
  CartModel? model;

  void getData(ShowCartStartEvent event, Emitter<CartStates>emit)async{
    emit(ShowCartLoadingState());
    final response = await serverGate.getFromServer(url: 'client/cart');
    if(response.success){
     final  cartModel= CartModel.fromJson(response.response!.data);

     print(cartModel.list.length.toString() +"-=======================-=-");
      emit(ShowCartSuccessState(model:cartModel));
    }
    else{
      emit(ShowCartFailedState(
          msg: response.msg,
          statusCode: response.errType!));
    }

  }

  void deleteFromCart(DeleteStartEvens event, Emitter<CartStates>emit)async{

    emit(DeleteFromCartLoadingState());
    final response = await serverGate.deleteFromServer(url: 'client/cart/delete_item/${event.id}');
    if (response.success){
      model!.list.removeAt(event.index);
      emit(DeleteFromCartSuccessState(msg: response.msg));

    }else{
      emit(DeleteFromCartFailedState(
          msg: response.msg,
          statusCode: response.errType!));
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

import 'package:bloc/bloc.dart';

import '../../../../helper/server_gate.dart';
import '../../../../models/product_rate_model.dart';

part 'events.dart';
part 'model.dart';
part 'states.dart';

class ProductBloc extends Bloc<ProductEvents,ProductState> {
  ProductBloc(this.serverGate) :super (ProductState()) {
    on<ShowProductStartEvent>(getShowProduct);
    on<GetProductRateStartEvent>(getProductRate);
    on<AddToFavoritesStartEvent>(AddToFavorite);
    on<RemoveFromFavoritesStartEvent>(RemoveFromFavorite);
  }

  ShowProductModel? showProductModel;
  ProductRateModel? productRateModel;
  final ServerGate serverGate;


  void getShowProduct(ShowProductStartEvent event , Emitter<ProductState>emit) async {

    
    emit (ShowProductLoadingState());
    
    final response = await serverGate.getFromServer(url: 'products/${event.productsId}');

    if(response.success){
      showProductModel= ShowProductModel.fromJson(response.response!.data);
      emit (ShowProductSuccessState());
    } else{
      emit(ShowProductFailedState(
          error: response.msg,
          errType: response.errType!));
    }
  }

  void getProductRate(GetProductRateStartEvent event, Emitter<ProductState>emit) async{

    emit(GetProductRateLoadingState());

    final response = await serverGate.getFromServer(url: 'products/${event.productsId}/rates');

    if(response.success){
      print(response.response!.data.toString()+"000000000000000");
      productRateModel = ProductRateModel.fromJson(response.response!.data);
      emit(GetProductRateSuccessState());
    }else{
      emit(GetProductRateFailedState(
          error: response.msg,
          errType: response.errType!));
    }

  }


  void AddToFavorite(AddToFavoritesStartEvent event, Emitter<ProductState>emit)async{

    emit(AddToFavoriteLoadingState());

    final response = await serverGate.sendToServer(url: 'client/products/${event.productsId}/add_to_favorite');
    if(response.success){
      emit(AddToFavoriteSuccessState());

    }else{
      emit(AddToFavoriteFailedState( error: response.msg, errType: response.errType!));
    }

  }


  void RemoveFromFavorite(RemoveFromFavoritesStartEvent event,Emitter<ProductState>emit)async{

    emit(RemoveFromFavoriteLoadingState());

    final response = await serverGate.sendToServer(url: 'client/products/${event.productsId}/remove_from_favorite');
    if(response.success){
      emit(RemoveFromFavoriteSuccessState());

    }else{
      emit(RemoveFromFavoriteFailedState(errType: response.errType!, error: response.msg));
    }

  }





}
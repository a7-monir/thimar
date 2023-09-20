
import 'package:bloc/bloc.dart';
import '../../../../models/product_rate_model.dart';
import '../../core/logic/server_gate.dart';

part 'events.dart';
part 'model.dart';
part 'states.dart';

class ProductBloc extends Bloc<ProductEvents,ProductStates> {
  ProductBloc(this.serverGate) :super (ProductStates()) {
    on<ShowProductStartEvent>(getData);
    on<GetProductRateStartEvent>(getProductRate);
    on<AddToFavoritesStartEvent>(AddToFavorite);
    on<RemoveFromFavoritesStartEvent>(RemoveFromFavorite);
  }

  ProductRateData? productRateModel;
  ShowProductData? showProductModel;
  final ServerGate serverGate;


  void getData(ShowProductStartEvent event , Emitter<ProductStates>emit) async {

    
    emit (ShowProductLoadingState());
    
    final response = await serverGate.getFromServer(url: 'products/${event.productsId}');

    if(response.success){
      final showProductModel= ShowProductData.fromJson(response.response!.data);
      emit (ShowProductSuccessState(model: showProductModel));
    } else{
      emit(ShowProductFailedState(
          msg: response.msg,
          statusCode: response.errType!));
    }
  }

  void getProductRate(GetProductRateStartEvent event, Emitter<ProductStates>emit) async{

    emit(GetProductRateLoadingState());

    final response = await serverGate.getFromServer(url: 'products/${event.productsId}/rates');

    if(response.success){
      print(response.response!.data.toString()+"000000000000000");
      final productRateModel = ProductRateData.fromJson(response.response!.data);
      emit(GetProductRateSuccessState(model: productRateModel));
    }else{
      emit(GetProductRateFailedState(
          msg: response.msg,
          statusCode: response.errType!));
    }

  }


  void AddToFavorite(AddToFavoritesStartEvent event, Emitter<ProductStates>emit)async{

    emit(AddToFavoriteLoadingState());

    final response = await serverGate.sendToServer(url: 'client/products/${event.productsId}/add_to_favorite');
    if(response.success){
      emit(AddToFavoriteSuccessState(msg: response.msg));

    }else{
      emit(AddToFavoriteFailedState( msg: response.msg, statusCode: response.errType!));
    }

  }


  void RemoveFromFavorite(RemoveFromFavoritesStartEvent event,Emitter<ProductStates>emit)async{

    emit(RemoveFromFavoriteLoadingState());

    final response = await serverGate.sendToServer(url: 'client/products/${event.productsId}/remove_from_favorite');
    if(response.success){
      emit(RemoveFromFavoriteSuccessState(msg: response.msg));

    }else{
      emit(RemoveFromFavoriteFailedState(statusCode: response.errType!, msg: response.msg));
    }

  }





}
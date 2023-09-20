



import 'package:bloc/bloc.dart';
import 'package:thimar/core/logic/helper_methods.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class FavoritesBloc extends Bloc<FavoritesEvents,FavoritesStates>{

  FavoritesBloc(this.serverGate):super (FavoritesStates()){

    on<FavoritesStartEvent>(getData);
  }

  final ServerGate serverGate;

  // int? categoriesProductId;


  void getData (FavoritesStartEvent event , Emitter<FavoritesStates> emit ) async{

    emit(FavoritesLoadingState());

    final response = await serverGate.getFromServer(url: 'client/products/favorites');

    if(response.success){

     final favoritesModel =FavoritesData.fromJson(response.response!.data);


      emit(FavoritesSuccessState(model: favoritesModel,));


    }else{ emit(FavoritesFailedState(
        msg: response.msg,
        statusCode: response.errType!));}
  }
}
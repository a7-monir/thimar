



import 'package:bloc/bloc.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class FavoritesBloc extends Bloc<FavoritesEvents,FavoritesState>{

  FavoritesBloc(this.serverGate):super (FavoritesState()){

    on<FavoritesStartEvent>(getFavorites);
  }

  final ServerGate serverGate;

  // int? categoriesProductId;
  FavoritesModel? model;

  void getFavorites (FavoritesStartEvent event , Emitter<FavoritesState> emit ) async{

    emit(FavoritesLoadingState());

    final response = await serverGate.getFromServer(url: 'client/products/favorites');

    if(response.success){

      model =FavoritesModel.fromJson(response.response!.data);


      emit(FavoritesSuccessState());


    }else{ emit(FavoritesFailedState(
        error: response.msg,
        errType: response.errType!));}
  }
}
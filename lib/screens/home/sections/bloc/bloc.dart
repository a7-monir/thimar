

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/screens/home/sections/bloc/states.dart';

import '../../../../helper/server_gate.dart';
import 'events.dart';
import 'model.dart';

class CategoriesProductBloc extends Bloc<CategoriesProductEvents,CategoriesProductStates>{

  CategoriesProductBloc():super (CategoriesProductStates()){

    on<CategoriesProductStartEvent>(GetCategoriesProduct);
  }

  ServerGate serverGate = ServerGate();
  // int? categoriesProductId;
  CategoryProductModel? model;

  void GetCategoriesProduct (CategoriesProductStartEvent event , Emitter<CategoriesProductStates>emit ) async{

    emit(CategoriesProductLoadingState());

    final response = await serverGate.getFromServer(

        url: 'categories/${event.categoriesProductId}');

    if(response.success){
      model =CategoryProductModel.fromJson(response.response!.data);
      emit(CategoriesProductSuccessState());

    }else{ emit(CategoriesProductFailedState(
        error: response.msg.toString(),
        errType: response.errType!.toInt()));}
  }
}


import 'package:bloc/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_get_products/states.dart';

import '../../helper/server_gate.dart';
import 'events.dart';
import 'model.dart';

class GetProductsBloc extends Bloc<GetProductsEvent,GetProductsState>{


  GetProductsBloc() : super(GetProductsState()) {
    on<GetProductsStartEvent>(GetProducts);
  }

  ServerGate serverGate = ServerGate();
  GetProductsModel? getProductsModel;


  void GetProducts(GetProductsStartEvent event, Emitter<GetProductsState> emit) async {
    emit(GetProductsLoadingState());

    final response = await serverGate.getFromServer(
      url: 'products',
    );
    if (response.success) {
      getProductsModel = GetProductsModel.fromJson(response.response!.data);
      emit(GetProductsSuccessState());
    } else {
      emit(GetProductsFailedState(
          error: response.msg.toString(), errType: response.errType!.toInt()));
    }
  }

}
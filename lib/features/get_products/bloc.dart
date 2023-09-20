
import 'package:bloc/bloc.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class GetProductsBloc extends Bloc<GetProductsEvents,ProductsStates>{


  GetProductsBloc(this.serverGate) : super(ProductsStates()) {
    on<GetProductsStartEvent>(GetProducts);

  }

  final ServerGate serverGate;



  void GetProducts(GetProductsStartEvent event, Emitter<ProductsStates> emit) async {
    emit(GetProductsLoadingState());

    final response = await serverGate.getFromServer(
      url: 'products',
    );
    if (response.success) {
      final productsModel = ProductsData.fromJson(response.response!.data);
      emit(GetProductsSuccessState(model:productsModel));
    } else {
      emit(GetProductsFailedState(
          msg: response.msg, statusCode: response.errType!));
    }
  }
  

}
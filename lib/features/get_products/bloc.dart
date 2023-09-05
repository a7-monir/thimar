
import 'package:bloc/bloc.dart';
import '../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class GetProductsBloc extends Bloc<GetProductsEvent,GetProductsState>{


  GetProductsBloc(this.serverGate) : super(GetProductsState()) {
    on<GetProductsStartEvent>(GetProducts);

  }

  final ServerGate serverGate;
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
          error: response.msg, errType: response.errType!));
    }
  }
  

}
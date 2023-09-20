import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class CategoriesProductBloc
    extends Bloc<CategoriesProductEvents, CategoriesProductStates> {
  CategoriesProductBloc(this.serverGate) : super(CategoriesProductStates()) {
    on<CategoriesProductStartEvent>(getData);

    //on<CategoriesProductStartEvent>(GetProducts);
  }

  final ServerGate serverGate;


  void getData(CategoriesProductStartEvent event, Emitter<CategoriesProductStates> emit) async {
    emit(CategoriesProductLoadingState());

    final response = await serverGate.getFromServer(url: 'products',
        params: {
      "category_id": event.productsId,
      if (event.min != null) "min_price": event.min,
      if (event.max != null) "max_price": event.max,
    });

    if (response.success) {
      final categoryProductModel = CategoryProductData.fromJson(response.response!.data);

      emit(CategoriesProductSuccessState(model:categoryProductModel ));
    } else {
      emit(CategoriesProductFailedState(
          error: response.msg, errType: response.errType!));
    }
  }
}

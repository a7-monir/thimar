import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class CategoriesProductBloc
    extends Bloc<CategoriesProductEvents, CategoriesProductStates> {
  CategoriesProductBloc(this.serverGate) : super(CategoriesProductStates()) {
    on<CategoriesProductStartEvent>(GetCategoriesProduct);

    //on<CategoriesProductStartEvent>(GetProducts);
  }

  final ServerGate serverGate;

  CategoryProductModel? model;

  void GetCategoriesProduct(CategoriesProductStartEvent event,
      Emitter<CategoriesProductStates> emit) async {
    emit(CategoriesProductLoadingState());

    final response = await serverGate.getFromServer(url: 'products',
        params: {
      "category_id": event.productsId,
      if (event.min != null) "min_price": event.min,
      if (event.max != null) "max_price": event.max,
    });

    if (response.success) {
      model = CategoryProductModel.fromJson(response.response!.data);

      emit(CategoriesProductSuccessState());
    } else {
      emit(CategoriesProductFailedState(
          error: response.msg, errType: response.errType!));
    }
  }
}

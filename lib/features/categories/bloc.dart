
import 'package:bloc/bloc.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';


class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this.serverGate) : super(CategoriesState()) {

    on<CategoriesStartEvent>(getData);

  }

  final ServerGate serverGate;

  // CategoriesModel? categoriesModel;



  void getData(CategoriesStartEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());

    final response = await serverGate.getFromServer(url: 'categories');

    //final model = CategoriesModel.fromJson(response.response!.data);

    if (response.success) {
      final categoriesModel = CategoriesData.fromJson(response.response!.data);

      emit(CategoriesSuccessState(model: categoriesModel));
    } else {
      emit(CategoriesFailedState(
          msg: response.msg, statusCode: response.errType!));
    }
  }



}


import 'package:bloc/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_categories/states.dart';

import '../../helper/server_gate.dart';
import 'events.dart';
import 'model.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {

    on<CategoriesStartEvent>(Categories);

  }

  ServerGate serverGate = ServerGate();

  CategoriesModel? categoriesModel;



  void Categories(CategoriesStartEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoadingState());

    final response = await serverGate.getFromServer(url: 'categories');

    //final model = CategoriesModel.fromJson(response.response!.data);

    if (response.success) {
      categoriesModel = CategoriesModel.fromJson(response.response!.data);

      emit(CategoriesSuccessState());
    } else {
      emit(CategoriesFailedState(
          error: response.msg.toString(), errType: response.errType!.toInt()));
    }
  }



}

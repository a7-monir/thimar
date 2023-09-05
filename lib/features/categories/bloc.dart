
import 'package:bloc/bloc.dart';
import '../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';


class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this.serverGate) : super(CategoriesState()) {

    on<CategoriesStartEvent>(Categories);

  }

  final ServerGate serverGate;

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
          error: response.msg, errType: response.errType!));
    }
  }



}

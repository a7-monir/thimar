import 'package:bloc/bloc.dart';
import '../../helper/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState> {
  SearchBloc(this.serverGate) : super(SearchState()) {
    on<SearchStartEvent>(Search);
  }
  final ServerGate serverGate;
  SearchModel? model;


  void Search(SearchStartEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    final response = await serverGate.getFromServer(url: 'search',
    params: {
      "keyword":event.keyword,

    });

    if (response.success) {
      model = SearchModel.fromJson(response.response!.data);
      emit(SearchSuccessState());
    } else {
      emit(SearchFailedState(
          error: response.msg, errType: response.errType!));
    }
  }





}

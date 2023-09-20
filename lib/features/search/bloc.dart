import 'package:bloc/bloc.dart';

import '../../core/logic/server_gate.dart';
part 'events.dart';
part 'model.dart';
part 'states.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  SearchBloc(this.serverGate) : super(SearchStates()) {
    on<SearchStartEvent>(Search);
  }
  final ServerGate serverGate;



  void Search(SearchStartEvent event, Emitter<SearchStates> emit) async {
    emit(SearchLoadingState());

    final response = await serverGate.getFromServer(url: 'search',
    params: {
      "keyword":event.keyword,

    });

    if (response.success) {
      final searchModel = SearchData.fromJson(response.response!.data);
      emit(SearchSuccessState(model:searchModel));
    } else {
      emit(SearchFailedState(
          msg: response.msg, statusCode: response.errType!));
    }
  }





}

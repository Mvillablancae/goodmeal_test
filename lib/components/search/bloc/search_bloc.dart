import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goodmeal_test/models/city.dart';
import 'package:goodmeal_test/models/cityForecast.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchIdle());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is Search)
      yield* _mapSearchToState();
    else if (event is SelectCity) yield* _selectCityToState();
  }

  Stream<SearchState> _mapSearchToState() async* {
    //TODO: implement _mapSearchToState
  }

  Stream<SearchState> _selectCityToState() async* {
    //TODO: implement _selectCityToState
  }
}

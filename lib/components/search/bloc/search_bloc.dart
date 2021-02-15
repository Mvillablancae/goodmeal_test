import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/models/city.dart';
import 'package:goodmeal_test/models/cityForecast.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchIdle());

  CitiesRepository _repository = CitiesRepository.instance;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is Search)
      yield* _mapSearchToState(event.searchString);
    else if (event is SelectCity) yield* _selectCityToState();
  }

  Stream<SearchState> _mapSearchToState(String searchText) async* {
    print("SearchingText: $searchText");
    yield SearchLoading();
    if (searchText?.length == 0)
      yield SearchIdle();
    else {
      List<City> cities = await _repository.filterCities(searchText);
      print("Cities Length: ${cities.length}");
      yield SearchStarted(filteredCities: cities);
    }
  }

  Stream<SearchState> _selectCityToState() async* {
    //TODO: implement _selectCityToState
  }
}

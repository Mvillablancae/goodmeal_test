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
    else if (event is SelectCity) yield* _selectCityToState(event.city);
  }

  @override
  void onChange(Change<SearchState> change) {
    super.onChange(change);
    print(change);
  }

  Stream<SearchState> _mapSearchToState(String searchText) async* {

    yield SearchLoading();
    if (searchText?.length == 0)
      yield SearchIdle();
    else {
      List<City> cities = await _repository.filterCities(searchText);
      yield SearchStarted(filteredCities: cities);
    }
  }

  Stream<SearchState> _selectCityToState(City selected) async* {
    yield SearchLoading();
    try {
      dynamic response = await _repository.getCityForecast(selected);
      if (response['status'] != 200) {
        yield SearchFailed();
      } else {

        yield SearchCompleted(
            selectedCity: selected, forecast: response['data']);
      }
    } catch (e) {
      print("error:$e");
    }

    //yield SearchFailed();
    //yield SearchCompleted(selectedCity: selected);
  }
}

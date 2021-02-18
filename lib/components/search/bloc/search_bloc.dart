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
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void changeSearchBarState() {
    _isSearching = !_isSearching;
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is Search)
      yield* _mapSearchToState(event.searchString);
    else if (event is SelectCity)
      yield* _selectCityToState(event.city);
    else if (event is OpenSearch) yield OpenedSearch();
  }

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  Stream<SearchState> _mapSearchToState(String searchText) async* {
    yield SearchLoading();
    if (_isSearching) {
      if (searchText?.length == 0) {
        changeSearchBarState();
        yield SearchIdle();
      } else {
        List<City> cities = await _repository.filterCities(searchText);
        changeSearchBarState();
        yield SearchStarted(filteredCities: cities);
      }
    }
  }

  Stream<SearchState> _selectCityToState(City selected) async* {
    yield SearchLoading();
    try {
      dynamic response = await _repository.getCityForecast(selected);
      if (response['status'] != 200) {
        yield SearchFailed(errorMsje: response);
      } else {
        yield SearchCompleted(
            selectedCity: selected, forecast: response['data']);
      }
    } catch (e) {
      print("error:$e");
      yield SearchFailed(
          errorMsje: {'status': 500, 'error': 'Revise su conexión a internet'});
    }
  }
}

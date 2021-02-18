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

  String _currentWord = "";

  set changeCurrentWord(String text) => _currentWord = text;

  String _lastSearchedWord = "";

  String get getlastSearchedWord =>
      _lastSearchedWord;

  bool _keepSearching = true;
  set setKeepSearching(bool flag) => _keepSearching = flag;

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
    List<City> cities;
    yield SearchLoading();
    _keepSearching = true;
    _isSearching = true;
    while (_keepSearching) {
      if (_currentWord.length == 0) {
        if (_isSearching) changeSearchBarState();
        _keepSearching = false;
        yield SearchIdle();
      } else if (_isSearching) {
        cities = await _repository.filterCities(_currentWord);
        if (_lastSearchedWord == _currentWord) {
          _keepSearching = false;
          changeSearchBarState();
          yield SearchStarted(filteredCities: cities);
        } else {
          _lastSearchedWord = _currentWord;
        }
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
      yield SearchFailed(
          errorMsje: {'status': 500, 'error': 'Revise su conexión a internet'});
    }
  }
}

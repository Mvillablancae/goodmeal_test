part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchIdle extends SearchState {}

class OpenedSearch extends SearchState {}

class SearchStarted extends SearchState {
  SearchStarted({this.filteredCities});

  final List<City> filteredCities;

  @override
  String toString() {
    return "Searching ${filteredCities.length} cities.";
  }
}

class SearchFailed extends SearchState {
  SearchFailed({this.errorMsje});
  final Map<String, dynamic> errorMsje;
}

class SearchLoading extends SearchState {}

class SearchCompleted extends SearchState {
  SearchCompleted({this.selectedCity, this.forecast});

  final City selectedCity;
  final CityForecast forecast;

  @override
  String toString() {
    return "Selected ${selectedCity.name} city.";
  }
}

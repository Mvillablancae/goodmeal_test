part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OpenSearch extends SearchEvent {
  OpenSearch();
}

class Search extends SearchEvent {
  Search({this.searchString});
  
  final String searchString;
}

class SelectCity extends SearchEvent {
  SelectCity({this.city});

  final City city;
}

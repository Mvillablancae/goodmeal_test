part of 'currentweather_bloc.dart';

@immutable
abstract class CurrentweatherState {}

class CurrentweatherEmpty extends CurrentweatherState {}

class CurrentweatherLoaded extends CurrentweatherState {
  CurrentweatherLoaded({this.forecast, this.city});
  final Forecast forecast;
  final City city;

  @override
  String toString() {
    super.toString();
    return "Ciudad ${city.name} cargada con: ${forecast.weather}";
  }
}

class CurrentweatherLoading extends CurrentweatherState {}

class CurrentweatherFailed extends CurrentweatherState {
  CurrentweatherFailed({this.error});

  final Map<String, dynamic> error;

  @override
  String toString() {
    super.toString();
    return "El error fue $error";
  }
}

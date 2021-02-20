import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:goodmeal_test/core/repositories/locationRepository.dart';
import 'package:goodmeal_test/core/models/city.dart';
import 'package:goodmeal_test/core/models/forecast.dart';
import 'package:meta/meta.dart';

part 'currentweather_event.dart';
part 'currentweather_state.dart';

class CurrentweatherBloc
    extends Bloc<CurrentweatherEvent, CurrentweatherState> {
  CurrentweatherBloc() : super(CurrentweatherEmpty());

  LocationRepository _locationRepository = LocationRepository.instance;
  CitiesRepository _citiesRepository = CitiesRepository.instance;

  @override
  Stream<CurrentweatherState> mapEventToState(
    CurrentweatherEvent event,
  ) async* {
    if (event is LoadCurrentWeather) {
      yield* _mapLoadCurrentWeatherToState();
    }
    // TODO: implement mapEventToState
  }

  Stream<CurrentweatherState> _mapLoadCurrentWeatherToState() async* {
    yield CurrentweatherLoading();
    try {
      //Map<String, String>
      dynamic currentLocationCoordinates =
          await _locationRepository.getCurrentCoordinates();
      if (currentLocationCoordinates["error"] == null) {
        dynamic localForecast = await _citiesRepository.getCurrentForecast(
            lat: currentLocationCoordinates["lat"],
            lon: currentLocationCoordinates["lat"]);
        if (localForecast["error"] == null) {
          dynamic cityName = _citiesRepository.getCityName(lat: currentLocationCoordinates["lat"] ,lon:currentLocationCoordinates["lon"]);
          yield CurrentweatherLoaded(forecast: localForecast["data"],city: City(name:cityName, lat:currentLocationCoordinates["lat"], lon:currentLocationCoordinates["lon"] ) );
        } else {
          yield CurrentweatherFailed(
              error: {"status": 500, "error": localForecast["error"]});
        }
      } else {
        yield CurrentweatherFailed(error: {
          "status": 500,
          "error": currentLocationCoordinates["error"]
        });
      }
    } catch (e) {
      print("(Current Weather)Error: $e");
      yield CurrentweatherFailed();
    }
  }
}

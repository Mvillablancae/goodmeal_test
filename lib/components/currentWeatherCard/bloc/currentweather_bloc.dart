import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currentweather_event.dart';
part 'currentweather_state.dart';

class CurrentweatherBloc
    extends Bloc<CurrentweatherEvent, CurrentweatherState> {
  CurrentweatherBloc() : super(CurrentweatherEmpty());

  @override
  Stream<CurrentweatherState> mapEventToState(
    CurrentweatherEvent event,
  ) async* {
    if (event is LoadCurrentWeather) {
      _mapLoadCurrentWeatherToState();
    }
    // TODO: implement mapEventToState
  }

  Stream<CurrentweatherState> _mapLoadCurrentWeatherToState() {}
}

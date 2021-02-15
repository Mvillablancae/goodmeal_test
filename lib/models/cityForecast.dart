import 'package:goodmeal_test/models/forecast.dart';

class CityForecast {
  CityForecast(
      {this.firstDayForecast, this.secondDayForecast, this.thirdDayForecast,this.temperatureRangeByDay});
  final List<Forecast> firstDayForecast;
  final List<Forecast> secondDayForecast;
  final List<Forecast> thirdDayForecast;
  final Map<String, String> temperatureRangeByDay;
}

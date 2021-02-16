import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:goodmeal_test/models/city.dart';
import 'package:http/http.dart' as http;

class GeographicDataService {
  Future<Map<String, List<City>>> loadCities() async {
    Map<String, List<City>> alphabeticOrderedCities = {};

    List<dynamic> json =
        jsonDecode(await rootBundle.loadString("assets/data/cities.json"));
    json.forEach((element) {
      City city = City(
          country: element["country"],
          name: element["name"],
          lat: element["lat"],
          lon: element["lng"]);
      if (alphabeticOrderedCities.keys.contains(city.name[0].toUpperCase())) {
        alphabeticOrderedCities[city.name[0].toUpperCase()].add(city);
      } else
        alphabeticOrderedCities[city.name[0].toUpperCase()] = [city];
    });
    return alphabeticOrderedCities;
  }

  Future<dynamic> loadCountries() async {
    return jsonDecode(
        await rootBundle.loadString("assets/data/countries.json"));
  }

  Future<dynamic> getCityForecast({String lat, String lon}) async {
    Uri uri = Uri.https('api.openweathermap.org', 'data/2.5/onecall', {
      'lat': lat,
      'lon': lon,
      'exclude': 'hourly, minutely, current',
      'appid': '942bb6fd45c5a2f1d2b4f1b1aa61f115'
    });
    http.Response response = await http.get(uri);
    if (response.statusCode != 200) {
      return {
        'status': response.statusCode,
        'error': 'Revise su conexión a internet'
      };
    } else {
      return {'status': response.statusCode, 'data': jsonDecode(response.body)};
    }
  }
}

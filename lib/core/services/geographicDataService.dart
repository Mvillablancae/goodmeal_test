import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:goodmeal_test/models/city.dart';

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
          lon: element["lon"]);
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
    //TODO: Implement Method
  }

}

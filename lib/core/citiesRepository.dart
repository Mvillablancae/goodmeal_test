import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodmeal_test/models/city.dart';

class CitiesRepository {
  static final CitiesRepository _instance = CitiesRepository();
  static CitiesRepository get instance => _instance;

  final Map<String, List<City>> alphabeticOrderCities = {};
  dynamic countries;

  Future<void> loadData() async {
    List<dynamic> json =
        jsonDecode(await rootBundle.loadString("assets/data/cities.json"));
    json.forEach((element) {
      City city = City(
          country: element["country"],
          name: element["name"],
          lat: element["lat"],
          lon: element["lon"]);
      if (alphabeticOrderCities.keys.contains(city.name[0].toUpperCase())) {
        alphabeticOrderCities[city.name[0].toUpperCase()].add(city);
      } else
        alphabeticOrderCities[city.name[0].toUpperCase()] = [city];
    });

    countries =
        jsonDecode(await rootBundle.loadString("assets/data/countries.json"));
  }
}

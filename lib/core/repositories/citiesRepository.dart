import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goodmeal_test/core/services/geographicDataService.dart';
import 'package:goodmeal_test/models/city.dart';

class CitiesRepository {
  static final CitiesRepository _instance = CitiesRepository();
  static CitiesRepository get instance => _instance;

  final GeographicDataService _service = GeographicDataService();
  final TextEditingController _searchFieldController = TextEditingController();

  String get searchingText => _searchFieldController.text;

  

  Map<String, List<City>> alphabeticOrderCities = {};
  dynamic countries;

  Future<void> loadData() async {
    alphabeticOrderCities = await _service.loadCities();
    countries = await _service.loadCountries();
  }
}

import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:goodmeal_test/core/services/geographicDataService.dart';
import 'package:goodmeal_test/core/models/city.dart';
import 'package:goodmeal_test/core/models/cityForecast.dart';
import 'package:goodmeal_test/core/models/forecast.dart';

class CitiesRepository {
  static final CitiesRepository _instance = CitiesRepository();
  static CitiesRepository get instance => _instance;

  final GeographicDataService _service = GeographicDataService();
  final TextEditingController _searchFieldController = TextEditingController();

  TextEditingController get textController => _searchFieldController;

  String get searchingText => _searchFieldController.text;

  Map<String, List<City>> alphabeticOrderCities = {};
  dynamic countries;

  Future<void> loadData() async {
    alphabeticOrderCities = await _service.loadCities();
    countries = await _service.loadCountries();
  }

  Future<List<City>> filterCities(String searchValue) async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(filter, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;

    List<City> filteredCities = await sendReceive(
      sendPort,
      {
        "cities": alphabeticOrderCities,
        "searchValue": searchValue,
      },
    );

    return filteredCities;
  }

  static Future<void> filter(SendPort sendPort) async {
    ReceivePort port = ReceivePort();

    sendPort.send(port.sendPort);

    await for (var msg in port) {
      Map<String, dynamic> data = msg[0];
      SendPort replyTo = msg[1];

      List<City> filtering = [];
      if (data['cities'][data['searchValue'][0].toString().toUpperCase()] ==
              null ||
          data['cities'][data['searchValue'][0].toString().toUpperCase()]
                  .length ==
              0)
        replyTo.send(filtering);
      else if (data['searchValue'].length == 1) {
        replyTo.send(data['cities']
                [data['searchValue'].toString().toUpperCase()]
            .take(10)
            .toList());
      } else {
        for (var element in data['cities']
            [data['searchValue'][0].toString().toUpperCase()]) {
          if (element.name
              .toUpperCase()
              .startsWith(data['searchValue'].toUpperCase()))
            filtering.add(element);
          if (filtering.length > 10) break;
        }
        replyTo.send(filtering);
      }
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }

  Future<dynamic> getCurrentForecast({String lat, String lon}) async {
    try {
      Map<String, dynamic> data =
          await _service.getCityForecast(lat: lat, lon: lon);
      if (data['status'] != 200)
        return data;
      else {
        Forecast forecast = Forecast(
            weather: data["data"]["daily"][0]['weather'][0]['main'],
            max: ((data["data"]["daily"][0]['temp']['max'] - 273.15).floor())
                .toString(),
            min: ((data["data"]["daily"][0]['temp']['min'] - 273.15).floor())
                .toString());

        return {
          'status': data['status'],
          'data': forecast,
        };
      }
    } catch (e) {
      return {'status': 500, 'error': '$e'};
    }
  }

  Future<Map<String, dynamic>> getCityName({String lat, String lon}) async {
    try {
      var name = await _service.getCityName(
        lat: lat,
        lon: lon,
      );
      if (name["error"] == null) {
        return {"status": 200, "cityName": name["cityName"],"country": name["country"]};
      } else {
        return {
          "status": 500,
          "error": "Error al obtener el nombre de la ciudad"
        };
      }
    } catch (e) {
      return {
        "status": 500,
        "error": "Error al obtener el nombre de la ciudad"
      };
    }
  }

  Future<dynamic> getCityForecast(City city) async {
    try {
      Map<String, dynamic> data =
          await _service.getCityForecast(lat: city.lat, lon: city.lon);
      if (data['status'] != 200)
        return data;
      else {
        List<Forecast> forecast = [];
        List elements = data['data']['daily'];
        for (int i = 0; i < 3; i++) {
          forecast.add(
            Forecast(
                weather: elements[i]['weather'][0]['main'],
                max: ((elements[i]['temp']['max'] - 273.15).floor()).toString(),
                min:
                    ((elements[i]['temp']['min'] - 273.15).floor()).toString()),
          );
        }
        return {
          'status': data['status'],
          'data': CityForecast(threeDayForecast: forecast)
        };
      }
    } catch (e) {
      return {'status': 500, 'error': 'Revise su conexión a internet'};
    }
  }
}

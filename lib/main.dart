import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/bloc/home_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/view/homeScreen.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherEveryWhere',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc()..add(LoadData()),
        lazy: false,
        child: HomeScreen()),
    );
  }
}

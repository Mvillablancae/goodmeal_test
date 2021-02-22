import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodmeal_test/components/currentWeatherCard/bloc/currentweather_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/bloc/home_bloc.dart';
import 'package:goodmeal_test/components/homeScreen/view/homeScreen.dart';
import 'package:goodmeal_test/components/search/bloc/search_bloc.dart';
import 'package:goodmeal_test/components/search/view/searchScreen.dart';
import 'package:goodmeal_test/components/search/view/selectedCity.dart';

class AppRouter {
  final SearchBloc _searchBloc = SearchBloc();
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) => HomeBloc()..add(LoadData()),
                    lazy: false,
                  ),
                  BlocProvider(
                    create: (context) => CurrentweatherBloc()..add(LoadCurrentWeather()),
                    lazy: false,
                  ),
                  BlocProvider.value(
                    value: _searchBloc,
                  ),
                ], child: HomeScreen()));
      case SelectedCity.routeName:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _searchBloc,
                  child: SelectedCity(),
                ));
      case SearchScreen.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider.value(value: _searchBloc, child: SearchScreen()));

      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}

part of 'currentweather_bloc.dart';

@immutable
abstract class CurrentweatherState {}

class CurrentweatherEmpty extends CurrentweatherState {}

class CurrentweatherLoaded extends CurrentweatherState {}

class CurrentweatherLoading extends CurrentweatherState {}

class CurrentweatherFailed extends CurrentweatherState {}
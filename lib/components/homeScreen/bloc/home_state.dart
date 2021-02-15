part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeUninitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeInitialized extends HomeState {}
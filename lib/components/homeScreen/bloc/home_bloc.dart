import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goodmeal_test/core/repositories/citiesRepository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeUninitialized());

  CitiesRepository _citiesRepository = CitiesRepository.instance;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadData) {
      yield* _mapLoadDataToState();
    }
  }

  Stream<HomeState> _mapLoadDataToState() async* {
    yield HomeLoading();
    await _citiesRepository.loadData();
    yield HomeInitialized();
  }
}

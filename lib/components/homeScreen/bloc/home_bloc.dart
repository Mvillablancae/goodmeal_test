import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeUninitialized());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadData) {
      yield* _mapLoadDataToState();
    }
  }


  Stream<HomeState> _mapLoadDataToState() async *{
    //TODO: Implement Method
  }
}

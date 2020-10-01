import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(LoadLoginPageState());

  @override
  Stream<RouteState> mapEventToState(
    RouteEvent event,
  ) async* {
    if (event is LoadMainMenuEvent) {
      yield LoadMainMenuState();
    } else if (event is LoadLoginPageEvent) {
      yield LoadLoginPageState();
    } else if (event is LoadDashboardPageEvent) {
      yield LoadDashboardPageState(pageIdn: event.pageIdn);
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../bloc.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(ConfigurePageState());

  @override
  Stream<RouteState> mapEventToState(
    RouteEvent event,
  ) async* {
    if (event is ConfigurePageEvent) {
      Key key = UniqueKey();
      yield ConfigurePageState(key: key);
    } else if (event is LoadMainMenuEvent) {
      yield LoadMainMenuState();
    } else if (event is LoadProfilePageEvent) {
      yield LoadProfilePageState();
    } else if (event is LoadLoginPageEvent) {
      yield LoginPageState();
    } else if (event is SignUpPageEvent) {
      yield SignUpPageState();
    } else if (event is LoadDashboardPageEvent) {
      yield LoadDashboardPageState(pageIdn: event.pageIdn);
    }
  }
}

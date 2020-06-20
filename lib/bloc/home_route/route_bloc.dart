import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  @override
  RouteState get initialState => InitialRouteState();

  @override
  Stream<RouteState> mapEventToState(
    RouteEvent event,
  ) async* {
    if (event is MainMenuEvent) {
      yield MainMenuState();
    } else if (event is ProductTypes) {
      yield ProductTypesState();
    } else if (event is ScannerEvent) {
      yield ScannerState();
    } else if (event is SalesEvent) {
      yield SalesState();
    } else if (event is BasketEvent) {
      yield BasketState();
    } else if (event is ProfileEvent) {
      yield ProfileState();
    } else if (event is SettingsEvent) {
      yield SettingsState();
    } else if ( event is LoginPageEvent) {
      yield LoginPageState();
    }
  }
}

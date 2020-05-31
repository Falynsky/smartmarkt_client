import 'package:equatable/equatable.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class LoginPageEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class MainMenuEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class ItemsEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class ScannerEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class SalesEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class BasketEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class ProfileEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class SettingsEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

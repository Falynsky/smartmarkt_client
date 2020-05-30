import 'package:equatable/equatable.dart';

abstract class RouteState extends Equatable {
  const RouteState();
}

class InitialRouteState extends RouteState {
  @override
  List<Object> get props => [];
}

class MainMenuState extends RouteState {
  @override
  List<Object> get props => [];
}

class ItemsState extends RouteState {
  @override
  List<Object> get props => [];

}
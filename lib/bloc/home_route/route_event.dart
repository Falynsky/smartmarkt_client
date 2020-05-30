import 'package:equatable/equatable.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class MainMenuEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class ItemsEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class ConfigurePageEvent extends RouteEvent {
  ConfigurePageEvent();

  @override
  List<Object> get props => [];
}

class LoadLoginPageEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class SignUpPageEvent extends RouteEvent {
  final Key key;

  SignUpPageEvent(this.key);

  @override
  List<Object> get props => [key];
}

class LoadMainMenuEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class LoadDashboardPageEvent extends RouteEvent {
  final String pageIdn;

  LoadDashboardPageEvent({
    @required this.pageIdn,
  });

  @override
  List<Object> get props => [
        pageIdn,
      ];
}

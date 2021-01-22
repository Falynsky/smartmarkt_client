import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RouteState extends Equatable {
  const RouteState();
}

class InitialRouteState extends RouteState {
  @override
  List<Object> get props => [];
}

class LoadProfilePageState extends RouteState {
  @override
  List<Object> get props => [];
}

class LoadMainMenuState extends RouteState {
  @override
  List<Object> get props => [];
}

class LoginPageState extends RouteState {
  @override
  List<Object> get props => [];
}

class SignUpPageState extends RouteState {
  @override
  List<Object> get props => [];
}

class LoadDashboardPageState extends RouteState {
  final String pageIdn;

  LoadDashboardPageState({
    @required this.pageIdn,
  });

  @override
  List<Object> get props => [
        pageIdn,
      ];
}

class ConfigurePageState extends RouteState {
  final Key key;

  ConfigurePageState({this.key});

  @override
  List<Object> get props => [
        key,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RouteState extends Equatable {
  const RouteState();
}

class LoadMainMenuState extends RouteState {
  @override
  List<Object> get props => [];
}

class LoadLoginPageState extends RouteState {
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

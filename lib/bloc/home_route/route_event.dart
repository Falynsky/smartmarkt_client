import 'package:equatable/equatable.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class LoadLoginPageEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class SignUpPageEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class LoadMainMenuEvent extends RouteEvent {
  @override
  List<Object> get props => [];
}

class LoadDashboardPageEvent extends RouteEvent {
  final String pageIdn;

  LoadDashboardPageEvent({
    this.pageIdn,
  });

  @override
  List<Object> get props => [
        pageIdn,
      ];
}

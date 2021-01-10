import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginLoadingEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoadedLoginEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginAccountEvent extends LoginEvent {
  final String login;
  final String password;

  LoginAccountEvent({
    @required this.login,
    @required this.password,
  });

  @override
  List<Object> get props => [
        login,
        password,
      ];
}

class LoginErrorOccurredEvent extends LoginEvent {
  final String title;
  final String msg;

  LoginErrorOccurredEvent({
    this.title,
    this.msg,
  });

  @override
  List<Object> get props => [
        title,
        msg,
      ];
}

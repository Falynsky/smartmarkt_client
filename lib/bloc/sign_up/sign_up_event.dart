import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpLoadingEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class LoadedSignUpEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class RegisterAccountEvent extends SignUpEvent {
  final String login;
  final String password;
  final String firstName;
  final String lastName;

  RegisterAccountEvent({
    @required this.login,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });

  @override
  List<Object> get props => [
        login,
        password,
        firstName,
        lastName,
      ];
}

class RegisterErrorOccurredEvent extends SignUpEvent {
  final String title;
  final String msg;

  RegisterErrorOccurredEvent({
    this.title,
    this.msg,
  });

  @override
  List<Object> get props => [
        title,
        msg,
      ];
}

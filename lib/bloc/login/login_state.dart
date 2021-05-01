import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadedLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class CorrectLoginState extends LoginState {
  final Key key;

  CorrectLoginState({key}) : key = UniqueKey();

  @override
  List<Object> get props => [key];
}

class LoginErrorOccurredState extends LoginState {
  final String title;
  final String msg;
  final Key key;

  LoginErrorOccurredState({
    required this.title,
    required this.msg,
    required this.key,
  });

  @override
  List<Object> get props => [
        title,
        msg,
        key,
      ];
}

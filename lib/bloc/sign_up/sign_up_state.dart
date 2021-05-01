import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object> get props => [];
}

class LoadedSignUpState extends SignUpState {
  @override
  List<Object> get props => [];
}

class CorrectRegisterState extends SignUpState {
  @override
  List<Object> get props => [];
}

class RegisterErrorOccurredState extends SignUpState {
  final String title;
  final String msg;
  final Key key;

  RegisterErrorOccurredState({
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

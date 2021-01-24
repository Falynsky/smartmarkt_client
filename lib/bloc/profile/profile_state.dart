import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class InitialProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadProfileScreenState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ShowBasketHistoryDialogState extends ProfileState {
  final Key key;

  ShowBasketHistoryDialogState({@required this.key});

  @override
  List<Object> get props => [
        key,
      ];
}

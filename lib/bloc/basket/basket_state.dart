import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BasketState extends Equatable {
  const BasketState();
}

class InitialBasketState extends BasketState {
  @override
  List<Object> get props => [];
}

class LoadingBasketState extends BasketState {
  final Key key;

  LoadingBasketState(this.key);
  @override
  List<Object> get props => [];
}

class LoadedBasketState extends BasketState {
  @override
  List<Object> get props => [];
}

class RemoveBasketProductsState extends BasketState {
  @override
  List<Object> get props => [];
}

class ShowBasketSnackBarState extends BasketState {
  final String message;

  ShowBasketSnackBarState({this.message});
  @override
  List<Object> get props => [message];
}

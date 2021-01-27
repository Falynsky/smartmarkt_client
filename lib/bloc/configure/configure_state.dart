import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConfigureState extends Equatable {
  const ConfigureState();
}

class LoadConfigureMenuState extends ConfigureState {
  @override
  List<Object> get props => [];
}

class ScanShopCodeState extends ConfigureState {
  @override
  List<Object> get props => [];
}

class ShopAvailableState extends ConfigureState {
  final Key key;

  ShopAvailableState(this.key);

  @override
  List<Object> get props => [];
}

class ShopUnAvailableState extends ConfigureState {
  final Key key;

  ShopUnAvailableState(this.key);
  @override
  List<Object> get props => [];
}

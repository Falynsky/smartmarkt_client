import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConfigureEvent extends Equatable {
  const ConfigureEvent();
}

class LoadConfigurePageEvent extends ConfigureEvent {
  @override
  List<Object> get props => [];
}

class ScanShopCodeEvent extends ConfigureEvent {
  @override
  List<Object> get props => [];
}

class CheckShopCodeEvent extends ConfigureEvent {
  final String storeAddress;

  CheckShopCodeEvent({@required this.storeAddress});

  @override
  List<Object> get props => [
        storeAddress,
      ];
}

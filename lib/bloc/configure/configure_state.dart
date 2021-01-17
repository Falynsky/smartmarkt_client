import 'package:equatable/equatable.dart';

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
  @override
  List<Object> get props => [];
}

class ShopUnAvailableState extends ConfigureState {
  @override
  List<Object> get props => [];
}

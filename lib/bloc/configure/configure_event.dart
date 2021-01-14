import 'package:equatable/equatable.dart';

abstract class ConfigureEvent extends Equatable {
  const ConfigureEvent();
}

class LoadConfigurePageEvent extends ConfigureEvent {
  @override
  List<Object> get props => [];
}

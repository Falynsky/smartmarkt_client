import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitialProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class LoadBasketHistoryEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ShowBasketHistoryDialogEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

import 'package:equatable/equatable.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();
}

class SalesLoadingEvent extends SalesEvent {
  @override
  List<Object> get props => [];
}

class LoadedSalesEvent extends SalesEvent {
  LoadedSalesEvent();

  @override
  List<Object> get props => [];
}

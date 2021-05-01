import 'package:equatable/equatable.dart';

abstract class ProductTypesEvent extends Equatable {
  const ProductTypesEvent();
}

class InitialProductTypesEvent extends ProductTypesEvent {
  InitialProductTypesEvent();

  @override
  List<Object> get props => [];
}

class LoadedProductTypesEvent extends ProductTypesEvent {
  LoadedProductTypesEvent();

  @override
  List<Object> get props => [];
}

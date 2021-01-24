import 'package:equatable/equatable.dart';

abstract class ProductTypesState extends Equatable {
  const ProductTypesState();
}

class InitialProductTypesState extends ProductTypesState {
  @override
  List<Object> get props => [];
}

class LoadedProductTypesState extends ProductTypesState {
  @override
  List<Object> get props => [];
}

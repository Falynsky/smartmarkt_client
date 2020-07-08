import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductTypesState extends ProductsState {
  @override
  List<Object> get props => [];
}

class SelectedTypeProductsState extends ProductsState {
  final Map productType;

  SelectedTypeProductsState({
    this.productType,
  });

  @override
  List<Object> get props => [];
}

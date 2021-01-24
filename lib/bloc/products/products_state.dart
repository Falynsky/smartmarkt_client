import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class InitialProductsState extends ProductsState {
  @override
  List<Object> get props => [];
}

class LoadedProductsState extends ProductsState {
  @override
  List<Object> get props => [];
}

class AddToBasketSucceedState extends ProductsState {
  final Key key;

  AddToBasketSucceedState(this.key);

  @override
  List<Object> get props => [
        key,
      ];
}

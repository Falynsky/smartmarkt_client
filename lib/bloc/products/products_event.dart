import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class LoadedProductTypesEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class SelectedTypeProductsEvent extends ProductsEvent {
  final Map productType;

  SelectedTypeProductsEvent({
    @required this.productType,
  });

  @override
  List<Object> get props => [
        productType,
      ];
}

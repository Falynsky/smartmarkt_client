import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    @required this.productType,
  });

  @override
  List<Object> get props => [];
}

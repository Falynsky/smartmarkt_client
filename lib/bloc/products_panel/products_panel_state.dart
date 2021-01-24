import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/models/product_type.dart';

abstract class ProductsPanelState extends Equatable {
  const ProductsPanelState();
}

class ProductTypesPageState extends ProductsPanelState {
  @override
  List<Object> get props => [];
}

class SelectedTypeProductsState extends ProductsPanelState {
  final ProductType productType;

  SelectedTypeProductsState({
    @required this.productType,
  });

  @override
  List<Object> get props => [];
}

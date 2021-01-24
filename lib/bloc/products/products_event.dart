import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class InitialProductsEvent extends ProductsEvent {
  final int productTypeId;

  InitialProductsEvent({this.productTypeId});

  @override
  List<Object> get props => [
        productTypeId,
      ];
}

class AddToBasketEvent extends ProductsEvent {
  final int productId;
  final int quantity;

  AddToBasketEvent({
    @required this.productId,
    @required this.quantity,
  });

  @override
  List<Object> get props => [
        productId,
        quantity,
      ];
}

class AddToBasketSucceedEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class LoadedProductsEvent extends ProductsEvent {
  LoadedProductsEvent();

  @override
  List<Object> get props => [];
}

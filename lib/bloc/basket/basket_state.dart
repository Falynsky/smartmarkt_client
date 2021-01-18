import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BasketState extends Equatable {
  const BasketState();
}

class InitialBasketState extends BasketState {
  @override
  List<Object> get props => [];
}

class LoadingBasketState extends BasketState {
  @override
  List<Object> get props => [];
}

class LoadedBasketState extends BasketState {
  final List<Map<String, dynamic>> basketProducts;
  final double basketSummary;

  LoadedBasketState({
    @required this.basketProducts,
    @required this.basketSummary,
  });

  @override
  List<Object> get props => [
        basketProducts,
        basketSummary,
      ];
}

class RemoveBasketProductsState extends BasketState {
  @override
  List<Object> get props => [];
}

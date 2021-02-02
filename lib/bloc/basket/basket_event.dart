import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();
}

class LoadingBasketEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}

class LoadingSummaryBasketEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}

class LoadedBasketEvent extends BasketEvent {
  final List<Map<String, dynamic>> basketProducts;

  LoadedBasketEvent({
    this.basketProducts,
  });

  @override
  List<Object> get props => [
        basketProducts,
      ];
}

class ClearBasketEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}

class RemoveBasketProductEvent extends BasketEvent {
  final int index;

  RemoveBasketProductEvent({@required this.index});

  @override
  List<Object> get props => [
        index,
      ];
}

class PurchaseBasketProductsEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}

class AddOneToBasketEvent extends BasketEvent {
  final int productId;

  AddOneToBasketEvent({@required this.productId});

  @override
  List<Object> get props => [];
}

class RemoveOneFromBasketEvent extends BasketEvent {
  final int productId;

  RemoveOneFromBasketEvent({@required this.productId});
  @override
  List<Object> get props => [productId];
}

class ShowBasketSnackBarEvent extends BasketEvent {
  final String message;

  ShowBasketSnackBarEvent({this.message});
  @override
  List<Object> get props => [message];
}

class BasketUnSucceedEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}
